defmodule Drunkard.Protobuf.Glass do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          desc: String.t()
        }
  defstruct [:id, :name, :desc]

  field :id, 1, type: :string
  field :name, 2, type: :string
  field :desc, 3, type: :string
end
