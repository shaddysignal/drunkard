defmodule DrunkardWeb.RecipeIngredientControllerTest do
  use DrunkardWeb.ConnCase

  alias Drunkard.Recipes

  @create_attrs %{amount: "120.5", ingredient: "some ingredient", is_garnish: true, is_optional: true, unit: "some unit"}
  @update_attrs %{amount: "456.7", ingredient: "some updated ingredient", is_garnish: false, is_optional: false, unit: "some updated unit"}
  @invalid_attrs %{amount: nil, ingredient: nil, is_garnish: nil, is_optional: nil, unit: nil}

  def fixture(:recipe_ingredient) do
    {:ok, recipe_ingredient} = Recipes.create_recipe_ingredient(@create_attrs)
    recipe_ingredient
  end

  describe "index" do
    test "lists all recipe_ingredients", %{conn: conn} do
      conn = get(conn, Routes.recipe_ingredient_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Recipe ingredients"
    end
  end

  describe "new recipe_ingredient" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.recipe_ingredient_path(conn, :new))
      assert html_response(conn, 200) =~ "New Recipe ingredient"
    end
  end

  describe "create recipe_ingredient" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.recipe_ingredient_path(conn, :create), recipe_ingredient: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.recipe_ingredient_path(conn, :show, id)

      conn = get(conn, Routes.recipe_ingredient_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Recipe ingredient"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.recipe_ingredient_path(conn, :create), recipe_ingredient: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Recipe ingredient"
    end
  end

  describe "edit recipe_ingredient" do
    setup [:create_recipe_ingredient]

    test "renders form for editing chosen recipe_ingredient", %{conn: conn, recipe_ingredient: recipe_ingredient} do
      conn = get(conn, Routes.recipe_ingredient_path(conn, :edit, recipe_ingredient))
      assert html_response(conn, 200) =~ "Edit Recipe ingredient"
    end
  end

  describe "update recipe_ingredient" do
    setup [:create_recipe_ingredient]

    test "redirects when data is valid", %{conn: conn, recipe_ingredient: recipe_ingredient} do
      conn = put(conn, Routes.recipe_ingredient_path(conn, :update, recipe_ingredient), recipe_ingredient: @update_attrs)
      assert redirected_to(conn) == Routes.recipe_ingredient_path(conn, :show, recipe_ingredient)

      conn = get(conn, Routes.recipe_ingredient_path(conn, :show, recipe_ingredient))
      assert html_response(conn, 200) =~ "some updated ingredient"
    end

    test "renders errors when data is invalid", %{conn: conn, recipe_ingredient: recipe_ingredient} do
      conn = put(conn, Routes.recipe_ingredient_path(conn, :update, recipe_ingredient), recipe_ingredient: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Recipe ingredient"
    end
  end

  describe "delete recipe_ingredient" do
    setup [:create_recipe_ingredient]

    test "deletes chosen recipe_ingredient", %{conn: conn, recipe_ingredient: recipe_ingredient} do
      conn = delete(conn, Routes.recipe_ingredient_path(conn, :delete, recipe_ingredient))
      assert redirected_to(conn) == Routes.recipe_ingredient_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.recipe_ingredient_path(conn, :show, recipe_ingredient))
      end
    end
  end

  defp create_recipe_ingredient(_) do
    recipe_ingredient = fixture(:recipe_ingredient)
    {:ok, recipe_ingredient: recipe_ingredient}
  end
end
