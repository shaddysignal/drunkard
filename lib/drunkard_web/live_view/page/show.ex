defmodule DrunkardWeb.LiveView.Page.Show do
  use Phoenix.LiveView

  alias Drunkard.Recipes

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.PageView, "index.html", assigns)
  end

  def hande_params(_params, _uri, socket) do
    {:noreply, socket}
  end

end
