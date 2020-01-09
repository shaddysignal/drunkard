defmodule Drunkard.Recipes.Recipe do
  use Drunkard, :schema

  alias Drunkard.Recipes.Tag

  schema "recipes" do
    field :name, :string
    field :desc, :string
    field :steps, :string
    belongs_to :glass, Drunkard.Recipes.Glass, foreign_key: :glass_uuid, references: :uuid
    embeds_many :recipe_ingredients, Drunkard.Recipes.RecipeIngredient
    field :ingredient_variations, {:array, {:array, :string}}
    many_to_many :tags, Drunkard.Recipes.Tag, join_through: "tag_recipe_link", join_keys: [recipe_uuid: :uuid, tag_uuid: :uuid], on_replace: :delete
    belongs_to :image, Drunkard.Assets.Image, foreign_key: :image_uuid, references: :uuid
    belongs_to :icon, Drunkard.Assets.Image, foreign_key: :icon_uuid, references: :uuid

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe = recipe |> Repo.preload([:tags])
    attrs = Map.put_new(attrs, :tags, [])
            |> Map.put_new(:ingredient_variations, [])
            |> fill_ingredient_variations(recipe)

    recipe
    |> cast(attrs, [:name, :desc, :steps, :glass_uuid, :image_uuid, :icon_uuid, :ingredient_variations])
    |> cast_embed(:recipe_ingredients)
    |> validate_required([:name, :recipe_ingredients])
    |> assoc_constraint(:glass)
    |> assoc_constraint(:image)
    |> assoc_constraint(:icon)
    |> put_assoc(:tags, Tag.ginsert(recipe.tags ++ attrs[:tags]))
    |> unique_constraint(:name)
  end

  defp fill_ingredient_variations(attrs, recipe) do
    # TODO: look into update operations and such
    ingredient_rows = recipe.recipe_ingredients ++ Map.get(attrs, :recipe_ingredients, [])
    |> Enum.reject(fn ri -> ri.is_optional || ri.is_garnish end)
    |> Enum.map(fn ri -> [ri.ingredient | ri.alternatives] end)

    depth = length(ingredient_rows) - 1

    Map.put(attrs, :ingredient_variations, flatten(construct_variants(ingredient_rows), depth))
  end

  defp construct_variants(ingredients, acc \\ [])
  defp construct_variants([], acc), do: acc
  defp construct_variants([ingredients | tail], acc) do
    Enum.map(ingredients, fn i -> construct_variants(tail, [i | acc]) end)
  end

  defp flatten(rows, depth) when depth <= 0, do: rows
  defp flatten(rows, depth) do
    flatten(Enum.flat_map(rows, &(&1)), depth - 1)
  end

end
