defmodule DrunkardWeb.LiveView.Search.Glass do
  use Phoenix.LiveView

  alias Drunkard.Recipes.Glass

  def mount(session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.GlassView, "search.html", assigns)
  end

  def handle_params(params, uri, socket) do

  end

  def handle_event("search", params, socket) do

  end
end
