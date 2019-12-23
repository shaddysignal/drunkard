defmodule Drunkard.Assets.Image do
  use Drunkard, :schema

  schema "images" do
    field :path, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:name, :path])
    |> validate_required([:name, :path])
  end
end
