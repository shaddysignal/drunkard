defmodule Drunkard do
  @moduledoc """
  Drunkard keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @doc """
  Specific schema definition for ecto modules
  """
  def schema do
    quote do
      use Ecto.Schema

      import Ecto.Query, only: [from: 2]
      import Ecto.Changeset

      alias Drunkard.Repo

      @primary_key { :uuid, :binary_id, [ autogenerate: true ] }
      @foreign_key_type :binary_id
      @timestamps_opts [ type: :utc_datetime ]

      def get_or_insert(_module, []), do: []
      def get_or_insert(module, values) do
        names = values |> Enum.map(&(&1.name))

        Repo.insert_all(module, values, on_conflict: :nothing)
        Repo.all(from m in module, where: m.name in ^names)
      end
    end
  end

  @doc """
  When used, dispatch to the appropriate scope.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

end
