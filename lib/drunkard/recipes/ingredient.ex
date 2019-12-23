defmodule Drunkard.Recipes.Ingredient do
  use Drunkard, :schema

  import Ecto.Query, only: [from: 2]
  alias Drunkard.Recipes.Tag
  alias Drunkard.Recipes.Ingredient
  alias Drunkard.Repo

  schema "ingredients" do
    field :name, :string
    field :desc, :string
    many_to_many :alternatives, Drunkard.Recipes.Ingredient, join_through: "ingredient_ingredient_link", join_keys: [ingredient_uuid: :uuid, alternative_uuid: :uuid], on_replace: :delete
    many_to_many :tags, Drunkard.Recipes.Tag, join_through: "tag_ingredient_link", join_keys: [ingredient_uuid: :uuid, tag_uuid: :uuid], on_replace: :delete
    belongs_to :image, Drunkard.Assets.Image, foreign_key: :image_uuid, references: :uuid
    belongs_to :icon, Drunkard.Assets.Image, foreign_key: :icon_uuid, references: :uuid

    timestamps()
  end

  def changeset(ingredient, attrs) do
    ingredient = ingredient |> Repo.preload([:tags, :alternatives])
    attrs = attrs |> Map.put_new(:alternatives, []) |> Map.put_new(:tags, [])

    ingredient
    |> cast(attrs, [:name, :desc, :image_uuid, :icon_uuid])
    |> validate_required([:name])
    |> assoc_constraint(:image)
    |> assoc_constraint(:icon)
    |> put_assoc(:alternatives, Ingredient.ginsert(ingredient.alternatives ++ attrs[:alternatives]))
    |> put_assoc(:tags, Tag.ginsert(ingredient.tags ++ attrs[:tags]))
    |> unique_constraint(:name)
  end

  def ginsert(ingredients) do
    datetime = DateTime.truncate(DateTime.utc_now(), :second)

    get_or_insert(
      Ingredient,
      ingredients
      |> Enum.map(fn
        ingredient when is_map(ingredient) -> Map.merge(ingredient, %{updated_at: datetime})
      end)
    )
  end
end
