defmodule DrunkardWeb.LiveView.User.Show do
  use Phoenix.LiveView

  alias Drunkard.Accounts

  def mount(%{guardian_default_token: token} = _session, socket) do
    {:ok, uuid, _claims} = Drunkard.Guardian.resource_from_token(token)

    {:ok, assign(socket, current_user: Accounts.get_user!(uuid))}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.UserView, "show.html", assigns)
  end

  def handle_params(%{"uuid" => uuid} = _params, _uri, socket) do
    {:noreply, socket |> assign(user: Accounts.get_user!(uuid))}
  end

end
