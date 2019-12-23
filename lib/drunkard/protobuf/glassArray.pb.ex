defmodule Drunkard.Protobuf.GlassArray do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          glass: [Drunkard.Protobuf.Glass.t()]
        }
  defstruct [:glass]

  field :glass, 1, repeated: true, type: Drunkard.Protobuf.Glass
end
