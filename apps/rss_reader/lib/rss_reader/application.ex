defmodule RssReader.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      RssReader.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: RssReader.PubSub}
      # Start a worker by calling: RssReader.Worker.start_link(arg)
      # {RssReader.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: RssReader.Supervisor)
  end
end
