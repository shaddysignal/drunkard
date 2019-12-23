defmodule DrunkardWeb.PageController do
  use DrunkardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", %{user_name: "Phoenix"})
  end

end
