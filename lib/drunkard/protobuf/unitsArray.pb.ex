defmodule Drunkard.Protobuf.UnitsArray do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          units: [Drunkard.Protobuf.Units.t()]
        }
  defstruct [:units]

  field :units, 1, repeated: true, type: Drunkard.Protobuf.Units
end
