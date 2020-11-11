defmodule RssReader.Feeds.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :string, []}
  @derive {Phoenix.Param, key: :uuid}
  schema "entries" do
    field :description, :string
    field :favorited, :boolean, default: false
    field :img, :string
    field :name, :string
    field :read, :boolean, default: false
    field :url, :string
    field :source, :id

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:uuid, :name, :url, :description, :favorited, :read])
    |> validate_required([:uuid, :name, :url, :description, :favorited, :read])
  end
end
