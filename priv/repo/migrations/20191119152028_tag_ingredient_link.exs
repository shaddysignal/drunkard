defmodule Drunkard.Repo.Migrations.Tag2Ingredient do
  use Ecto.Migration

  def change do
    create table(:tag_ingredient_link, primary_key: false) do
      add :tag_uuid, references(:tags, column: :uuid, type: :binary_id)
      add :ingredient_uuid, references(:ingredients, column: :uuid, type: :binary_id)
    end
  end
end
