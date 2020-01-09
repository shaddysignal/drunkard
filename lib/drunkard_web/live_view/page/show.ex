defmodule DrunkardWeb.LiveView.Page.Show do
  use Phoenix.LiveView

  alias Drunkard.Recipes

  def mount(_session, socket) do
    {:ok, default_assign(socket)}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.PageView, "index.html", assigns)
  end

  def hande_params(_params, _uri, socket) do
    {:noreply, default_assign(socket)}
  end

  defp default_assign(socket) do
    assign(socket, random_recipe: Recipes.get_random_recipe!() |> Recipes.recipe_preload([:image]))
  end

end
