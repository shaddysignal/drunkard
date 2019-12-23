defmodule Drunkard.Protobuf.IngredientArray do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          ingredient: [Drunkard.Protobuf.Ingredient.t()]
        }
  defstruct [:ingredient]

  field :ingredient, 1, repeated: true, type: Drunkard.Protobuf.Ingredient
end
