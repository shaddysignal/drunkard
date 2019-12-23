defmodule Drunkard.Recipes.IngredientToIngredient do
  use Drunkard, :schema

  alias Drunkard.Recipes.Ingredient

  @primary_key false
  schema "ingredient_ingredient_link" do
    belongs_to :ingredient, Ingredient, foreign_key: :ingredient_uuid, references: :uuid
    belongs_to :alternative, Ingredient, foreign_key: :alternative_uuid, references: :uuid
  end

  def changeset(ingredient_alternative, params \\ %{}) do
    ingredient_alternative
    |> cast(params, [:ingredient_uuid, :alternative_uuid])
    |> validate_required([:ingredient_uuid, :alternative_uuid])
    |> assoc_constraint(:ingredient)
    |> assoc_constraint(:alternative)
    |> unique_constraint(:ingredient_alternative, name: :ingredient_alternative_uk)
  end
end
