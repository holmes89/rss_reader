defmodule RssReaderWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `RssReaderWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, RssReaderWeb.SourceLive.FormComponent,
        id: @source.id || :new,
        action: @live_action,
        source: @source,
        return_to: Routes.source_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts, active: true]
    live_component(socket, RssReaderWeb.ModalComponent, modal_opts)
  end
end
