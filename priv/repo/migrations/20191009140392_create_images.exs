defmodule Drunkard.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images, primary_key: false) do
      add :uuid, :binary_id, primary_key: true
      add :name, :string, null: false
      add :path, :string, null: false

      timestamps()
    end

    create unique_index(:images, [:name])
  end
end
