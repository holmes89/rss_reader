defmodule RssReader.Feeds.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :description, :string
    field :entry_date, :date
    field :favorited, :boolean, default: false
    field :img, :string
    field :name, :string
    field :read, :boolean, default: false
    field :url, :string
    field :uuid, :string
    field :source, :id

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:uuid, :name, :url, :entry_date, :img, :description, :favorited, :read])
    |> validate_required([:uuid, :name, :url, :entry_date, :img, :description, :favorited, :read])
  end
end
