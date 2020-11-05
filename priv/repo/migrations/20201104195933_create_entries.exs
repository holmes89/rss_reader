defmodule RssReader.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries, primary_key: false) do
      add :uuid, :string, primary_key: true
      add :name, :string
      add :url, :string
      add :entry_date, :date
      add :img, :string
      add :description, :string
      add :favorited, :boolean, default: false, null: false
      add :read, :boolean, default: false, null: false
      add :source, references(:sources, on_delete: :nothing)

      timestamps()
    end

    create index(:entries, [:source])
  end
end
