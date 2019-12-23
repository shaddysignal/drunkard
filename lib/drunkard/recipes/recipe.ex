defmodule Drunkard.Recipes.Recipe do
  use Drunkard, :schema

  alias Drunkard.Recipes.Tag

  schema "recipes" do
    field :name, :string
    field :desc, :string
    field :steps, :string
    belongs_to :glass, Drunkard.Recipes.Glass, foreign_key: :glass_uuid, references: :uuid
    embeds_many :recipe_ingredients, Drunkard.Recipes.RecipeIngredient
    many_to_many :tags, Drunkard.Recipes.Tag, join_through: "tag_recipe_link", join_keys: [recipe_uuid: :uuid, tag_uuid: :uuid], on_replace: :delete
    belongs_to :image, Drunkard.Assets.Image, foreign_key: :image_uuid, references: :uuid
    belongs_to :icon, Drunkard.Assets.Image, foreign_key: :icon_uuid, references: :uuid

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe = recipe |> Repo.preload([:tags])
    attrs = Map.put_new(attrs, :tags, [])

    recipe
    |> cast(attrs, [:name, :desc, :steps, :glass_uuid, :image_uuid, :icon_uuid])
    |> cast_embed(:recipe_ingredients)
    |> validate_required([:name, :recipe_ingredients])
    |> assoc_constraint(:glass)
    |> assoc_constraint(:image)
    |> assoc_constraint(:icon)
    |> put_assoc(:tags, Tag.ginsert(recipe.tags ++ attrs[:tags]))
    |> unique_constraint(:name)
  end
end
