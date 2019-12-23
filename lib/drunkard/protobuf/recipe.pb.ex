defmodule Drunkard.Protobuf.RecipeIngredient do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          amount: non_neg_integer,
          unit_id: String.t(),
          id_of_alternative: [String.t()],
          is_optional_ingredient: boolean,
          is_garnish: boolean
        }
  defstruct [:id, :amount, :unit_id, :id_of_alternative, :is_optional_ingredient, :is_garnish]

  field :id, 1, type: :string
  field :amount, 2, type: :uint32
  field :unit_id, 3, type: :string
  field :id_of_alternative, 4, repeated: true, type: :string
  field :is_optional_ingredient, 6, type: :bool
  field :is_garnish, 7, type: :bool
end

defmodule Drunkard.Protobuf.Recipe do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          ingredient: [Drunkard.Protobuf.RecipeIngredient.t()],
          glass_id: String.t(),
          tag: [String.t()]
        }
  defstruct [:id, :name, :ingredient, :glass_id, :tag]

  field :id, 1, type: :string
  field :name, 2, type: :string
  field :ingredient, 5, repeated: true, type: Drunkard.Protobuf.RecipeIngredient
  field :glass_id, 6, type: :string
  field :tag, 7, repeated: true, type: :string
end
