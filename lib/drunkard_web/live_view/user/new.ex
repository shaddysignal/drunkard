defmodule DrunkardWeb.LiveView.User.New do
  use Phoenix.LiveView

  alias DrunkardWeb.Router.Helpers, as: Routes
  alias Drunkard.Accounts
  alias Drunkard.Accounts.User

  def mount(_session, socket) do
    changeset = Accounts.change_user!(%User{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns), do: Phoenix.View.render(DrunkardWeb.UserView, "new.html", assigns)

  def handle_event("validate", %{"user" => user_params} = _params, socket) do
    changeset =
      %User{}
      |> Accounts.change_user!(user_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user_params} = _params, socket) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        {:stop,
         socket
         |> put_flash(:info, "user created")
         |> redirect(to: Routes.live_path(socket, DrunkardWeb.LiveView.User.Show, user))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
