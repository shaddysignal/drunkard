defmodule Drunkard.Protobuf.Units do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          one: String.t(),
          some: String.t(),
          many: String.t()
        }
  defstruct [:id, :one, :some, :many]

  field :id, 1, type: :string
  field :one, 2, type: :string
  field :some, 3, type: :string
  field :many, 4, type: :string
end
