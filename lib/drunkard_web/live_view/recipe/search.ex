defmodule DrunkardWeb.LiveView.Recipe.Search do
  use Phoenix.LiveView

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.RecipeView, "search.html", assigns)
  end
end
