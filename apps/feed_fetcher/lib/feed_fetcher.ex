defmodule FeedFetcher do
  use GenServer

  alias RssReader.Feeds.Entry
  alias RssReader.Feeds

  @name FeedFetcher

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: FeedFetcher])
  end

  def fetch_feed(source_id, endpoint) do
    GenServer.cast(@name, %{endpoint: endpoint, source_id: source_id})
  end

  ## Server Callbacks

  @impl true
  def init(:ok) do
    HTTPoison.start
    {:ok, %{}}
  end

  @impl true
  def handle_cast(%{source_id: source_id, endpoint: endpoint}, _stats) do
    case fetch_entries(source_id, endpoint) do
      {:ok, results} ->
        Enum.map results, fn(entry) -> Feeds.create_entry(entry) end
        {:noreply, results}
      _ ->
        {:noreply, :error}
      end
  end

  ## Helper Functions

  defp fetch_entries(source_id, endpoint) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(endpoint)
    {:ok, feed, _} = FeederEx.parse(body)
    results = Enum.map feed.entries, fn(entry) -> %{
      uuid: (:crypto.hash(:sha256, entry.link) |> Base.encode16()),
      description: entry.summary,
      img: entry.image,
      name: entry.title,
      source: source_id,
      url: entry.link} end
    {:ok, results}
  end

end
