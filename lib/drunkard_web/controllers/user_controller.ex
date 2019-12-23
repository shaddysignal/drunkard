defmodule DrunkardWeb.UserController do
  use DrunkardWeb, :controller

  alias Drunkard.Accounts
  alias Drunkard.Accounts.User

  action_fallback DrunkardWeb.FallbackController

  def index(conn, _params) do
    {:ok, users} = Accounts.list_users()
    _current_user = Accounts.get_current_user!(conn)

    # TODO customize index based on current user

    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      new_conn = Accounts.sign_in_user!(conn, user)
      token = Accounts.get_current_token!(new_conn)

      new_conn
      |> put_status(:created)
      |> render("show.json", user: user, token: token)
    end
  end

  def show(conn, %{"uuid" => uuid}) do
    with {:ok, %User{} = user} <- Accounts.get_user(uuid) do
      _current_user = Accounts.get_current_user!(conn)

      # TODO customize show depending on current user

      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"uuid" => uuid, "user" => user_params}) do
    user = Accounts.get_user!(uuid)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    else
      _ -> raise "update failed"
    end
  end

  def delete(conn, %{"uuid" => uuid}) do
    user = Accounts.get_user!(uuid)
    _current_user = Accounts.get_current_user!(conn)

    # TODO what exaclty happends when user delete itself

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    else
      _ -> raise "delete failed"
    end
  end
end
