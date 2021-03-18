defmodule JpixlWeb.Component.Cell do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  import Phoenix.LiveView

  @impl true
  def mount(_assigns, socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(fill_color: "")
    {:ok, socket}
  end
end
