defmodule DrunkardWeb.LiveView.Ingredient.Selector do
  use Phoenix.LiveView

  alias Drunkard.Recipes

  def mount(_session, socket) do
    {:ok, default_assign(socket)}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.IngredientView, "selector.html", assigns)
  end

  def handle_event("select", %{"ingredient-uuid" => iuuid} = _params, socket) do
    selected = case Enum.member?(socket.assigns.selected, iuuid) do
      true -> socket.assigns.selected -- [iuuid]
      false -> [iuuid | socket.assigns.selected]
    end

    {:noreply, assign(socket, selected: selected) |> assign_recipes(selected)}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  defp default_assign(socket) do
    starting_ingredients = Recipes.get_ingredients_and_preload!(["Ice", "Salt", "Sugar", "Water"], []) |> Enum.map(fn i -> i.uuid end)

    socket
    |> assign_recipes(starting_ingredients)
    |> assign_ingredients()
    |> assign_selected_ingredients(starting_ingredients)
  end

  defp assign_recipes(socket, selected) do
    recipes = Recipes.get_recipes_by_ingredients_preload!(%{ingredient_uuids: selected, preload_fiedls: [:icon]})

    assign(socket, recipes: recipes)
  end

  defp assign_ingredients(socket) do
    ingredients = Recipes.list_ingredients([:icon])

    assign(socket, ingredients: ingredients)
  end

  defp assign_selected_ingredients(socket, selected) do
    assign(socket, selected: selected)
  end

end
