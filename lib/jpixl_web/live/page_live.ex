defmodule JpixlWeb.PageLive do
  use JpixlWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(primary_color: "black")
      |> assign(secondary_color: "")
      |> assign(canvas_height: 32)
      |> assign(canvas_width: 32)
      |> assign(state: new_state())
      |> assign(show_grid: false)
    {:ok, socket}
  end

  def handle_event("paint_cell_secondary_color", data, socket) do
    {row, _} = Integer.parse(data["row"])
    {column, _} = Integer.parse(data["column"])

    {:noreply,
      socket
      |> assign(state: set_pixel(socket.assigns.state, row, column, socket.assigns.secondary_color))
    }
  end

  def handle_event("paint_cell_primary_color", data, socket) do
    {row, _} = Integer.parse(data["row"])
    {column, _} = Integer.parse(data["column"])
    {:noreply,
      socket
      |> assign(state: set_pixel(socket.assigns.state, row, column, socket.assigns.primary_color))
    }
  end

  def handle_event("set_primary_color", color, socket) do
    {:noreply,
      socket
      |> assign(primary_color: color)
    }
  end

  def handle_event("set_secondary_color", color, socket) do
    {:noreply,
      socket
       |> assign(secondary_color: color)
    }
  end

  def handle_event("update_canvas", form, socket) do
    {height, _} = Integer.parse(form["canvas_height"])
    {width, _} = Integer.parse(form["canvas_width"])
    {:noreply, socket
     |> assign(canvas_height: height)
     |> assign(canvas_width: width)
    }
  end

  def handle_event("set_grid", form, socket) do
    if Map.has_key?(form, "show_grid") do
      {:noreply,
        socket
        |> assign(show_grid: true)
      }
    else
      {:noreply,
        socket
        |> assign(show_grid: false)
      }
    end

  end

  defp new_state() do
    for row <- 0..31 do
      for row <- 0..31 do
        ""
      end
    end
  end

  defp get_pixel(state, row, col) do
    state |> Enum.at(row) |> Enum.at(col)
  end

  defp set_pixel(state, row, col, val) do
    List.replace_at(state, row, state |> Enum.at(row) |> List.replace_at(col, val))
  end

end
