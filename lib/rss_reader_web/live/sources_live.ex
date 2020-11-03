defmodule RssReaderWeb.SourcesLive do

  use RssReaderWeb, :live_view

  alias RssReader.Sources

  def mount(_params, _session, socket) do
        {:ok, assign(socket, :sources, Sources.list_sources())}
  end

  def render(assigns) do
    ~L"""
    <h1>Sources</h1>
    <ul>
      <%= for source <- @sources do %>
        <li><%= source.name %></li>
      <% end %>
    </ul>
    """
  end

end
