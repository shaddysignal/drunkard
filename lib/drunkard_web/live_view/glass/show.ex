defmodule DrunkardWeb.LiveView.Glass.Show do
  use Phoenix.LiveView

  alias Drunkard.Recipes

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(DrunkardWeb.GlassView, "show.html", assigns)
  end

  def handle_params(%{"uuid" => uuid} = _params, _uri, socket) do
    {:noreply, socket |> assign(glass: Recipes.get_glass!(%{uuid: uuid}) |> Recipes.glass_preload([:image, recipes: [:icon]]))}
  end

end
