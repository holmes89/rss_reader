defmodule FeedFetcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :feed_fetcher,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison],
      mod: {FeedFetcher.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rss_reader, in_umbrella: true},
      {:httpoison, "~> 1.7"},
      {:feeder_ex, "~> 1.1.0"}
    ]
  end
end
