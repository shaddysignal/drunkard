defmodule DrunkardWeb.LiveView.Recipe.New do
  use Phoenix.LiveView

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.RecipeView, "new.html", assigns)
  end

end
