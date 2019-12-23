defmodule DrunkardWeb.LiveView.Recipe.Show do
  use Phoenix.LiveView

  alias Drunkard.Recipes

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.RecipeView, "show.html", assigns)
  end

  def handle_params(%{"uuid" => uuid} = _params, _uri, socket) do
    recipe = Recipes.get_recipe!(%{uuid: uuid}) |> Recipes.recipe_preload([:image])
    ingredients = recipe.recipe_ingredients
                    |> Enum.map(fn ri -> %{uuid: ri.ingredient} end)
                    |> Enum.map(fn m -> Recipes.get_ingredient!(m) |> Recipes.ingredient_preload([:icon]) end)

    {:noreply, socket |> assign(recipe: recipe, ingredients: ingredients)}
  end

end
