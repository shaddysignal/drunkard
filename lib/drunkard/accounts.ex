defmodule Drunkard.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Drunkard.Repo

  alias Drunkard.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      {:ok, [%User{}, ...]}

  """
  def list_users do
    {:ok, Repo.all(User)}
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(uuid), do: Repo.get!(User, uuid)

  def get_user(uuid) do
    case Repo.get(User, uuid) do
      nil -> {:error, :user_not_found}
      user -> {:ok, user}
    end
  end

  def get_user_by_email(email) do
    email = String.downcase(email)

    case Repo.one(from(u in User, where: fragment("lower(?)", u.email) == ^email)) do
      nil -> {:error, :user_not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user, user_params \\ %{}) do
    {:ok, User.changeset(user, user_params)}
  end

  def change_user!(%User{} = user, user_params \\ %{}) do
    User.changeset(user, user_params)
  end

  # Token related functions

  def get_current_token!(conn) do
    case Drunkard.Guardian.Plug.current_token(conn) do
      nil -> raise "conn doesn't contain a token"
      token -> token
    end
  end

  def get_claims!(conn) do
    case Drunkard.Guardian.Plug.current_claims(conn) do
      nil -> raise "conn doesn't contain claims"
      claims -> claims
    end
  end

  def get_current_user!(conn) do
    case Drunkard.Guardian.Plug.current_resource(conn) do
      nil -> raise "conn doesn't contain a resource"
      resource -> resource
    end
  end

  def refresh_token(token), do: Drunkard.Guardian.refresh(token)

  def sign_out!(conn), do: Drunkard.Guardian.Plug.sign_out(conn)

  def sign_in_user!(conn, user), do: Drunkard.Guardian.Plug.sign_in(conn, user)

  def authenticate(%{"email" => email, "password" => password}) do
    {:ok, user} = get_user_by_email(email)

    case check_password(user, password) do
      true -> {:ok, user}
      _ -> {:error, :you_fucked_up}
    end
  end

  defp check_password(nil, _), do: Argon2.no_user_verify()
  defp check_password(%User{password_hash: password_hash}, password) do
    Argon2.verify_pass(password, password_hash)
  end

end
