defmodule FeedWatcher do
  @moduledoc """
  Documentation for `FeedWatcher`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FeedWatcher.hello()
      :world

  """
  def fetch(endpoint) do
    HTTPoison.start
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(endpoint)
    {:ok, feed, _} = FeederEx.parse(body)
    Enum.map feed.entries, fn(entry) -> %{id: (:crypto.hash(:sha256, entry.id) |> Base.encode16()) , url: entry.link, updated: entry.updated} end
  end
end
