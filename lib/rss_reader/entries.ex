defmodule RssReader.Entries do
    @moduledoc """
    Entry context
    """

  alias RssReader.Feeds.Entry

  def list_entries do
    [
      %Entry{id: "1", name: "Entry 1", url: "https://news.ycombinator.com/rss"},
      %Entry{id: "2", name: "Entry 1", url: "https://lobste.rs/rss"}
    ]
  end

  def get_entry(id) do
    Enum.find(list_entries(), fn map -> map.id == id end)
  end

end
