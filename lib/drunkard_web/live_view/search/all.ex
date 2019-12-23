defmodule DrunkardWeb.LiveView.Search.All do
  use Phoenix.LiveView

  alias Drunkard.Recipes
  alias Drunkard.Recipes.Ingredient
  alias Drunkard.Recipes.Recipe
  alias Drunkard.Recipes.Glass

  alias DrunkardWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    {:ok, assign_default(socket)}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.SearchView, "index.html", assigns)
  end

  def handle_params(%{"value" => value} = _params, _uri, socket) do
    all = get_all!(value) |> pair_with_modules()

    {:noreply, assign_default(socket) |> assign(found: all)}
  end
  def handle_params(_params, _uri, socket), do: {:noreply, assign_default(socket)}

  def handle_event("suggest", %{"search" => %{"part" => query}} = _params, socket) when byte_size(query) >= 4 and byte_size(query) <= 25 do
    all = get_all!(query)

    {:noreply, assign_default(socket) |> assign(matches: all |> Enum.map(&(&1.name)))}
  end
  def handle_event("suggest", _params, socket) do
    {:noreply, assign_default(socket)}
  end
  def handle_event("search", %{"search" => %{"part" => part}} = _params, socket) do
    {:noreply, socket |> live_redirect(to: Routes.live_path(socket, DrunkardWeb.LiveView.Search.All, part))}
  end

  defp assign_default(socket) do
    assign(socket, query: nil, result: nil, loading: false, matches: [], found: [])
  end

  defp get_all!(name_part) do
    glasses = Recipes.get_glasses_and_preload!(%{name_part: name_part})
    ingredients = Recipes.get_ingredients_and_preload!(%{name_part: name_part})
    recipes = Recipes.get_recipes_and_preload!(%{name_part: name_part})

    glasses ++ ingredients ++ recipes
  end

  defp pair_with_modules(all) do
    all |> Enum.map(&pair_with_module/1)
  end

  defp pair_with_module(%Recipe{} = elem), do: {elem, DrunkardWeb.LiveView.Recipe.Show}
  defp pair_with_module(%Ingredient{} = elem), do: {elem, DrunkardWeb.LiveView.Ingredient.Show}
  defp pair_with_module(%Glass{} = elem), do: {elem, DrunkardWeb.LiveView.Glass.Show}
end
