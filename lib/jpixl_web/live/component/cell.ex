defmodule JpixlWeb.Component.Cell do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  import Phoenix.LiveView

  def mount(socket) do
    IO.inspect socket
    {:ok, socket}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(fill_color: "")
      |> assign(assigns)
    IO.inspect socket.assigns

    {:ok, socket}
  end
end
