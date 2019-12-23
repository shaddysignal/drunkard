defmodule Drunkard.Recipes.Glass do
  use Drunkard, :schema

  schema "glasses" do
    field :desc, :string
    field :name, :string
    has_many :recipes, Drunkard.Recipes.Recipe, foreign_key: :glass_uuid
    belongs_to :image, Drunkard.Assets.Image, foreign_key: :image_uuid, references: :uuid
    belongs_to :icon, Drunkard.Assets.Image, foreign_key: :icon_uuid, references: :uuid

    timestamps()
  end

  @doc false
  def changeset(glass, attrs) do
    glass
    |> cast(attrs, [:name, :desc, :image_uuid, :icon_uuid])
    |> validate_required([:name, :desc])
    |> assoc_constraint(:image)
    |> assoc_constraint(:icon)
    |> unique_constraint(:name)
  end
end

defimpl Drunkard.Recipes.Slug, for: Drunkard.Recipes.Glass do
  def slugify(glass) do
    glass.name
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end
end

defimpl Phoenix.Param, for: Drunkard.Recipes.Glass do
  def to_param(glass) do
    Drunkard.Recipes.Slug.slugify(glass)
  end
end
