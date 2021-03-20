defmodule JpixlWeb.Component.Cell do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  import Phoenix.LiveView

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    {:ok,
      socket
      |> assign(assigns)
    }
  end
end
