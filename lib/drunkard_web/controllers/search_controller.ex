defmodule DrunkardWeb.SearchController do
  use DrunkardWeb, :controller

  import Ecto.Query, only: [from: 2]

  alias Drunkard.Repo
  alias Drunkard.Recipes.Glass
  alias Drunkard.Recipes.Ingredient
  alias Drunkard.Recipes.Recipe
  alias Drunkard.Recipes.Tag

  def search(conn, %{glass_name_part: glass_name_part} = _params) do
    glasses = Repo.all(from g in Glass, where: like(g.name, ^"%#{glass_name_part}%"), preload: [:icon, :image, :recipes])

  end
  def search(conn, %{ingredient_name_part: ingredient_name_part} = _params) do

  end
  def search(conn, %{recipe_name_part: recipe_name_part} = _params) do

  end
  def search(conn, %{tag_name_part: tag_name_part} = _params) do

  end

  def search_recipe(conn, %{} = _params) do

  end
end
