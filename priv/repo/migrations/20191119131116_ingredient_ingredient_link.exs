defmodule Drunkard.Repo.Migrations.IngredientToIngredient do
  use Ecto.Migration

  def change do
    create table(:ingredient_ingredient_link, primary_key: false) do
      add :ingredient_uuid, references(:ingredients, column: :uuid, type: :binary_id, on_delete: :delete_all)
      add :alternative_uuid, references(:ingredients, column: :uuid, type: :binary_id, on_delete: :delete_all)
    end

    create unique_index(:ingredient_ingredient_link, [:ingredient_uuid, :alternative_uuid], name: :ingredient_alternative_uk)
  end
end
