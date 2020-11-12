defmodule RssReaderWeb.EntryLive.Index do
  use RssReaderWeb, :live_view

  alias RssReader.Feeds

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :entries, list_entries())}
  end

  defp list_entries() do
    Feeds.list_entries()
  end
end
