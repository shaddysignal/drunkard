defmodule Drunkard.Repo.Migrations.TagRecipeLink do
  use Ecto.Migration

  def change do
    create table(:tag_recipe_link, primary_key: false) do
      add :tag_uuid, references(:tags, column: :uuid, type: :binary_id)
      add :recipe_uuid, references(:recipes, column: :uuid, type: :binary_id)
    end
  end
end
