defmodule DrunkardWeb.GlassController do
  use DrunkardWeb, :controller

  alias Drunkard.Recipes
  alias Drunkard.Recipes.Glass

  def index(conn, _params) do
    glasses = Recipes.list_glasses()
    render(conn, "index.html", glasses: glasses)
  end

  def new(conn, _params) do
    changeset = Recipes.change_glass(%Glass{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"glass" => glass_params}) do
    case Recipes.create_glass(glass_params) do
      {:ok, glass} ->
        conn
        |> put_flash(:info, "Glass created successfully.")
        |> redirect(to: Routes.glass_path(conn, :show, glass))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    glass = Recipes.get_glass!(id)
    render(conn, "show.html", glass: glass)
  end

  def edit(conn, %{"id" => id}) do
    glass = Recipes.get_glass!(id)
    changeset = Recipes.change_glass(glass)
    render(conn, "edit.html", glass: glass, changeset: changeset)
  end

  def update(conn, %{"id" => id, "glass" => glass_params}) do
    glass = Recipes.get_glass!(id)

    case Recipes.update_glass(glass, glass_params) do
      {:ok, glass} ->
        conn
        |> put_flash(:info, "Glass updated successfully.")
        |> redirect(to: Routes.glass_path(conn, :show, glass))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", glass: glass, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    glass = Recipes.get_glass!(id)
    {:ok, _glass} = Recipes.delete_glass(glass)

    conn
    |> put_flash(:info, "Glass deleted successfully.")
    |> redirect(to: Routes.glass_path(conn, :index))
  end
end
