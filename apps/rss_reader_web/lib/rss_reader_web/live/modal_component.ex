defmodule RssReaderWeb.ModalComponent do
  use RssReaderWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div id="<%= @id %>" class="modal <%= if @active do 'is-active' end %>"
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-target="#<%= @id %>"
      phx-page-loading>
      <div class="modal-background" >
      </div>
      <div class="modal-card">
        <section class="modal-card-body">
          <%= live_patch raw("&times;"), to: @return_to, class: "modal-close" %>
          <%= live_component @socket, @component, @opts %>
        </section>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
