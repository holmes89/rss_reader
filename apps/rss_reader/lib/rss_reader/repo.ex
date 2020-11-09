defmodule RssReader.Repo do
  use Ecto.Repo,
    otp_app: :rss_reader,
    adapter: Ecto.Adapters.Postgres
end
