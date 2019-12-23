defmodule Drunkard.Protobuf.RecipeArray do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          recipe: [Drunkard.Protobuf.Recipe.t()]
        }
  defstruct [:recipe]

  field :recipe, 1, repeated: true, type: Drunkard.Protobuf.Recipe
end
