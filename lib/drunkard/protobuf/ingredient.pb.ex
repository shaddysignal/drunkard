defmodule Drunkard.Protobuf.Ingredient do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          id_of_alternative: String.t(),
          tag: [String.t()]
        }
  defstruct [:id, :name, :id_of_alternative, :tag]

  field :id, 1, type: :string
  field :name, 2, type: :string
  field :id_of_alternative, 3, type: :string
  field :tag, 4, repeated: true, type: :string
end
