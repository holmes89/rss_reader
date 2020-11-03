defmodule RssReader.Feeds.Entry do
  defstruct [:id, :name, :url, :entry_date, :img, :description, :read, :favorited]
end
