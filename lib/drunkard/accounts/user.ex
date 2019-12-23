defmodule Drunkard.Accounts.User do
  use Drunkard, :schema

  alias Drunkard.Accounts.User

  @password_min_length 10
  @password_max_length 255

  @derive {Phoenix.Param, key: :uuid}

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
    Common changeset for user
  """
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/)
    |> unique_constraint(:email)
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_length(:password, min: @password_min_length, max: @password_max_length)
    |> put_password_hash
  end

  def update_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_password
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
      _ ->
        changeset
    end
  end

  defp validate_password(changeset) do
    changeset
  end

end
