defmodule JpixlWeb.PageLive do
  use JpixlWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("clear_cell", id, socket) do
    send_update(JpixlWeb.Component.Cell, id: id, fill_color: "")
    {:noreply, socket}
  end

  def handle_event("paint_cell", id, socket) do
    send_update(JpixlWeb.Component.Cell, id: id, fill_color: "black")
    {:noreply, socket}
  end
end
