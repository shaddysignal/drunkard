defmodule DrunkardWeb.AuthErrorController do
  import Plug.Conn
  use DrunkardWeb, :controller

  alias DrunkardWeb.Router.Helpers, as: Routes

  def auth_error(conn, {type, reason}, _opts) do
    IO.inspect("type: #{type}")
    IO.inspect("reason: #{reason}")

    conn
    |> put_flash(:info, "please login")
    |> redirect(to: Routes.session_path(conn, :new))
    |> halt()
  end
end
