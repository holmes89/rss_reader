defmodule FeedWatcher do
  use GenServer
  @moduledoc """
  Documentation for `FeedWatcher`.
  """

  @doc """
  Fetch data from endpoint.

  ## Examples

      iex> FeedWatcher.fetch(endpoint)
      fetchs data from endpoint

  """
  def fetch(endpoint) do

  end

  def init(endpoint) do
    HTTPoison.start
    send(self(), :poll) # Immediately schedule the first poll
    {:ok, endpoint}
  end

  def handle_info(:fetch, endpoint) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(endpoint)
    {:ok, feed, _} = FeederEx.parse(body)
    results = Enum.map feed.entries, fn(entry) -> %{id: (:crypto.hash(:sha256, entry.link) |> Base.encode16()) , url: entry.link, updated: entry.updated} end
    # IO.inspect results
    {:noreply, endpoint}
  end

  def handle_info(:poll, state) do

    send(self(), :fetch) # Immediately schedule the first poll

    # Re-schedule the next poll in 1 minute (60_000 ms):
    Process.send_after(self, :poll, 60_000)

    {:noreply, state}
  end
end
