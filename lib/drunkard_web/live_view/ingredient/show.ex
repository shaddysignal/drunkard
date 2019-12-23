defmodule DrunkardWeb.LiveView.Ingredient.Show do
  use Phoenix.LiveView

  alias Drunkard.Recipes

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.IngredientView, "show.html", assigns)
  end

  def handle_params(%{"uuid" => uuid} = _params, _uri, socket) do
    ingredient = Recipes.get_ingredient!(%{uuid: uuid}) |> Recipes.ingredient_preload([:image])
    recipes = Recipes.get_recipes_by_ingredient_preload!(%{ingredient_uuid: ingredient.uuid})

    {:noreply, socket |> assign(ingredient: ingredient, recipes: recipes)}
  end

end
