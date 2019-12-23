defmodule Drunkard.Accounts.TokenAuthority do
  alias :mnesia, as: Mnesia
  alias :lbm_kv, as: Lbm

  require Logger

  def init(_salt) do
    case Node.list() do
      # First node in cluster
      [] ->
        :ok = Lbm.create(__MODULE__)
        Logger.info("Created new store")

      # Replicate from existing
      _ ->
        Logger.info("Starting replication: #{NaiveDateTime.utc_now}")
        # Wait 60 sec for tables
        :ok = Mnesia.wait_for_tables([__MODULE__], 60_000)
        :ok = Lbm.create(__MODULE__)
        Logger.info("Replication done: #{NaiveDateTime.utc_now}")
    end

    {:ok, %{}}
  end

  def store_token(nil, _), do: {:error, :something_is_nil}
  def store_token(sub, token) do
    {:ok, _saved} = Lbm.put(__MODULE__, sub, token)

    {:ok, [sub: token]}
  end

  def remove_token(nil), do: {:error, :something_is_nil}
  def remove_token(sub) do
    case Lbm.del(__MODULE__, sub) do
      {:error, error} -> {:error, error}
      {:ok, []} -> {:error, :spoon_is_not_there}
      {:ok, removed} -> {:ok, removed}
    end
  end

  def find_token(nil), do: {:error, :something_is_nil}
  def find_token(sub) do
    case Lbm.get(__MODULE__, sub) do
      {:error, error} -> {:error, error}
      {:ok, []} -> {:error, :spoon_is_not_there}
      {:ok, found} -> {:ok, found}
    end
  end

end
