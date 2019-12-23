defmodule Drunkard.Recipes.Tag do
  use Drunkard, :schema

  alias Drunkard.Recipes.Tag

  schema "tags" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def ginsert(tags) do
    datetime = DateTime.truncate(DateTime.utc_now(), :second)

    get_or_insert(
      Tag,
      tags
      |> Enum.map(fn
        tag when is_bitstring(tag) -> %{name: tag, inserted_at: datetime, updated_at: datetime}
        tag when is_map(tag) -> %{name: tag.name, inserted_at: tag.inserted_at, updated_at: datetime}
      end)
    )
  end
end
