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
                    |> Enum.map(fn ri -> Map.put(ri, :ingredient, %{uuid: ri.ingredient}) end)
                    |> Enum.map(fn ri -> Map.put(ri, :ingredient, loadup_ingredient(ri.ingredient)) end)
                    |> Enum.map(fn ri -> Map.put(ri, :alternatives, Enum.map(ri.alternatives, fn a -> %{uuid: a} end)) end)
                    |> Enum.map(fn ri -> Map.put(ri, :alternatives, Enum.map(ri.alternatives, &loadup_ingredient/1)) end)

    {:noreply, socket |> assign(recipe: recipe, recipe_ingredients: ingredients)}
  end

  defp loadup_ingredient(m) do
    Recipes.get_ingredient!(m) |> Recipes.ingredient_preload([:icon])
  end

end
