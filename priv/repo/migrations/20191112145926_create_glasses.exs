defmodule Drunkard.Repo.Migrations.CreateGlasses do
  use Ecto.Migration

  def change do
    create table(:glasses, primary_key: false) do
      add :uuid, :binary_id, primary_key: true
      add :name, :string, null: false
      add :desc, :text
      add :image_uuid, references(:images, column: :uuid, type: :binary_id)
      add :icon_uuid, references(:images, column: :uuid, type: :binary_id)

      timestamps()
    end

    create unique_index(:glasses, [:name])
  end
end
