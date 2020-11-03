defmodule RssReader.Sources do
  @moduledoc """
  Sources context
  """

  alias RssReader.Feeds.Source

  def list_sources do
    [
      %Source{id: "1", name: "Hacker News", url: "https://news.ycombinator.com/rss"},
      %Source{id: "2", name: "Lobsters", url: "https://lobste.rs/rss"}
    ]
  end

  def get_source(id) do
    Enum.find(list_sources(), fn map -> map.id == id end)
  end
end
