defmodule DrunkardWeb.LayoutView do
  use DrunkardWeb, :view
  use Phoenix.LiveView

  def render_layout(layout, assigns, do: content) do
    render(layout, Map.put(assigns, :inner_layout, content))
  end
end
