defmodule RssReader.Repo.Migrations.CreateSources do
  use Ecto.Migration

  def change do
    create table(:sources) do
      add :name, :string
      add :url, :string

      timestamps()
    end

  end
end
