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
    {:ok, socket}
  end

  def handle_event("paint_cell_secondary_color", id, socket) do
    send_update(JpixlWeb.Component.Cell, id: id, fill_color: socket.assigns.secondary_color)
    {:noreply, socket}
  end

  def handle_event("paint_cell_primary_color", id, socket) do
    send_update(JpixlWeb.Component.Cell, id: id, fill_color: socket.assigns.primary_color)
    {:noreply, socket}
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
    IO.inspect form
    {height, _} = Integer.parse(form["canvas_height"])
    {width, _} = Integer.parse(form["canvas_width"])
    {:noreply, socket
     |> assign(canvas_height: height)
     |> assign(canvas_width: width)
    }
  end

end
