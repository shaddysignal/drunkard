defmodule DrunkardWeb.SessionController do
  use DrunkardWeb, :controller

  alias DrunkardWeb.Router.Helpers, as: Routes
  alias Drunkard.Accounts
  alias Drunkard.Accounts.User

  action_fallback(DrunkardWeb.FallbackController)

  def new(conn, _params) do
    conn
    |> put_view(DrunkardWeb.UserView)
    |> render("login.html", changeset: Accounts.change_user!(%User{}))
  end

  def state(conn, %{"user" => login_params}= _params) do
    with {:ok, user} <- Accounts.authenticate(login_params) do
      new_conn = Accounts.sign_in_user!(conn, user)

      new_conn
      |> put_flash(:info, "login successful")
      |> redirect(to: Routes.live_path(new_conn, DrunkardWeb.LiveView.User.Show, user))
    else
      {:error, error} ->
        conn
        |> put_flash(:error, "Error happend: #{error}")
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end

  def create(conn, params) do
    with {:ok, user} <- Accounts.authenticate(params) do
      new_conn = Accounts.sign_in_user!(conn, user)
      token = Accounts.get_current_token!(new_conn)

      new_conn
      |> put_status(:created)
      |> render("show.json", user: user, token: token)
    end
  end

  def delete(conn, _) do
    with new_conn = Accounts.sign_out!(conn) do
      new_conn
      |> put_status(:ok)
      |> render("delete.json")
    end
  end

  def refresh(conn, _params) do
    user = Accounts.get_current_user!(conn)

    with token = Accounts.get_current_token!(conn),
         {:ok, _, {new_token, _new_claims}} <- Accounts.refresh_token(token) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user, token: new_token)
    end
  end
end
