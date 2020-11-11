defmodule FeedWatcher do
  use GenServer

  alias RssReader.Feeds

  # @name FeedWatcher

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: FeedWatcher])
  end

  # Server

  @impl true
  def init(endpoint) do
    send(self(), :poll) # Immediately schedule the first poll
    {:ok, endpoint}
  end

  @impl true
  def handle_info(:fetch, endpoint) do
    Enum.map Feeds.list_sources(), fn x -> GenServer.cast(FeedFetcher, %{source_id: x.id, endpoint: x.url}) end
    {:noreply, endpoint}
  end

  @impl true
  def handle_info(:poll, state) do

    send(self(), :fetch) # Immediately schedule the first poll

    # Re-schedule the next poll in 1 minute (60_000 ms):
    Process.send_after(self(), :poll, 60_000)

    {:noreply, state}
  end
end
