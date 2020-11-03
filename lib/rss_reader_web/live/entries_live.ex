defmodule RssReaderWeb.EntriesLive do

  use RssReaderWeb, :live_view

  alias RssReader.Entries

  def mount(_params, _session, socket) do
        {:ok, assign(socket, :entries, Entries.list_entries())}
  end

  def render(assigns) do
    ~L"""
    <h1>Entries</h1>
    <ul>
      <%= for entry <- @entries do %>
        <li><%= entry.name %></li>
      <% end %>
    </ul>
    """
  end
end
