defmodule Drunkard.Recipes.RecipeIngredient do
  use Drunkard, :schema

  embedded_schema do
    field :amount, :decimal
    field :is_garnish, :boolean, default: false
    field :is_optional, :boolean, default: false
    field :unit, :string
    field :alternatives, {:array, :binary_id}
    field :ingredient, :binary_id

    timestamps()
  end

  @doc false
  def changeset(recipe_ingredient, attrs) do
    recipe_ingredient
    |> cast(attrs, [:amount, :unit, :is_optional, :is_garnish, :unit, :ingredient, :alternatives])
    |> validate_required([:amount, :unit, :is_optional, :is_garnish])
  end
end
