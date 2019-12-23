defmodule Drunkard.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes, primary_key: false) do
      add :uuid, :binary_id, primary_key: true
      add :name, :string, null: false
      add :desc, :text
      add :steps, :text
      add :glass_uuid, references(:glasses, column: :uuid, type: :binary_id)
      add :recipe_ingredients, :map
      add :image_uuid, references(:images, column: :uuid, type: :binary_id)
      add :icon_uuid, references(:images, column: :uuid, type: :binary_id)

      timestamps()
    end

    create unique_index(:recipes, [:name])
  end
end
