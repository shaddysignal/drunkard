defmodule DrunkardWeb.LiveView.User.Login do
  use Phoenix.LiveView

  alias DrunkardWeb.Router.Helpers, as: Routes
  alias Drunkard.Accounts
  alias Drunkard.Accounts.User

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.UserView, "login.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, changeset: Accounts.change_user!(%User{}))}
  end

  def handle_event("login", %{"user" => user_params} = _params, socket) do
    case Accounts.authenticate(user_params) do
      {:ok, user} ->
        {:stop,
        socket
        |> put_flash(:info, "login successful")
        |> redirect(to: Routes.live_path(socket, DrunkardWeb.LiveView.User.Show, user))}

      {:error, error} ->
        {:noreply, put_flash(socket, :error, "Error happend: #{error}")}
    end
  end

end
