defmodule JpixlWeb.PageLive do
  use JpixlWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(primary_color: "black")
      |> assign(secondary_color: "")
    {:ok, socket}
  end

  def handle_event("clear_cell", id, socket) do
    send_update(JpixlWeb.Component.Cell, id: id, fill_color: socket.assigns.secondary_color)
    {:noreply, socket}
  end

  def handle_event("paint_cell", id, socket) do
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


  end
