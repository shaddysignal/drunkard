defmodule Drunkard.RecipesTest do
  use Drunkard.DataCase

  alias Drunkard.Recipes

  describe "ingredients" do
    alias Drunkard.Recipes.Ingredient

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def ingredient_fixture(attrs \\ %{}) do
      {:ok, ingredient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_ingredient()

      ingredient
    end

    test "list_ingredients/0 returns all ingredients" do
      ingredient = ingredient_fixture()
      assert Recipes.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = ingredient_fixture()
      assert Recipes.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      assert {:ok, %Ingredient{} = ingredient} = Recipes.create_ingredient(@valid_attrs)
      assert ingredient.name == "some name"
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{} = ingredient} = Recipes.update_ingredient(ingredient, @update_attrs)
      assert ingredient.name == "some updated name"
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Recipes.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{}} = Recipes.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = ingredient_fixture()
      assert %Ecto.Changeset{} = Recipes.change_ingredient(ingredient)
    end
  end

  describe "glasses" do
    alias Drunkard.Recipes.Glass

    @valid_attrs %{desc: "some desc", image_path: "some image_path", name: "some name"}
    @update_attrs %{desc: "some updated desc", image_path: "some updated image_path", name: "some updated name"}
    @invalid_attrs %{desc: nil, image_path: nil, name: nil}

    def glass_fixture(attrs \\ %{}) do
      {:ok, glass} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_glass()

      glass
    end

    test "list_glasses/0 returns all glasses" do
      glass = glass_fixture()
      assert Recipes.list_glasses() == [glass]
    end

    test "get_glass!/1 returns the glass with given id" do
      glass = glass_fixture()
      assert Recipes.get_glass!(glass.id) == glass
    end

    test "create_glass/1 with valid data creates a glass" do
      assert {:ok, %Glass{} = glass} = Recipes.create_glass(@valid_attrs)
      assert glass.desc == "some desc"
      assert glass.image_path == "some image_path"
      assert glass.name == "some name"
    end

    test "create_glass/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_glass(@invalid_attrs)
    end

    test "update_glass/2 with valid data updates the glass" do
      glass = glass_fixture()
      assert {:ok, %Glass{} = glass} = Recipes.update_glass(glass, @update_attrs)
      assert glass.desc == "some updated desc"
      assert glass.image_path == "some updated image_path"
      assert glass.name == "some updated name"
    end

    test "update_glass/2 with invalid data returns error changeset" do
      glass = glass_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_glass(glass, @invalid_attrs)
      assert glass == Recipes.get_glass!(glass.id)
    end

    test "delete_glass/1 deletes the glass" do
      glass = glass_fixture()
      assert {:ok, %Glass{}} = Recipes.delete_glass(glass)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_glass!(glass.id) end
    end

    test "change_glass/1 returns a glass changeset" do
      glass = glass_fixture()
      assert %Ecto.Changeset{} = Recipes.change_glass(glass)
    end
  end

  describe "recipes" do
    alias Drunkard.Recipes.Recipe

    @valid_attrs %{glass: "some glass", name: "some name"}
    @update_attrs %{glass: "some updated glass", name: "some updated name"}
    @invalid_attrs %{glass: nil, name: nil}

    def recipe_fixture(attrs \\ %{}) do
      {:ok, recipe} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_recipe()

      recipe
    end

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Recipes.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Recipes.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      assert {:ok, %Recipe{} = recipe} = Recipes.create_recipe(@valid_attrs)
      assert recipe.glass == "some glass"
      assert recipe.name == "some name"
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{} = recipe} = Recipes.update_recipe(recipe, @update_attrs)
      assert recipe.glass == "some updated glass"
      assert recipe.name == "some updated name"
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe(recipe, @invalid_attrs)
      assert recipe == Recipes.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Recipes.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe(recipe)
    end
  end

  describe "recipe_ingredients" do
    alias Drunkard.Recipes.RecipeIngredient

    @valid_attrs %{amount: "120.5", ingredient: "some ingredient", is_garnish: true, is_optional: true, unit: "some unit"}
    @update_attrs %{amount: "456.7", ingredient: "some updated ingredient", is_garnish: false, is_optional: false, unit: "some updated unit"}
    @invalid_attrs %{amount: nil, ingredient: nil, is_garnish: nil, is_optional: nil, unit: nil}

    def recipe_ingredient_fixture(attrs \\ %{}) do
      {:ok, recipe_ingredient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_recipe_ingredient()

      recipe_ingredient
    end

    test "list_recipe_ingredients/0 returns all recipe_ingredients" do
      recipe_ingredient = recipe_ingredient_fixture()
      assert Recipes.list_recipe_ingredients() == [recipe_ingredient]
    end

    test "get_recipe_ingredient!/1 returns the recipe_ingredient with given id" do
      recipe_ingredient = recipe_ingredient_fixture()
      assert Recipes.get_recipe_ingredient!(recipe_ingredient.id) == recipe_ingredient
    end

    test "create_recipe_ingredient/1 with valid data creates a recipe_ingredient" do
      assert {:ok, %RecipeIngredient{} = recipe_ingredient} = Recipes.create_recipe_ingredient(@valid_attrs)
      assert recipe_ingredient.amount == Decimal.new("120.5")
      assert recipe_ingredient.ingredient == "some ingredient"
      assert recipe_ingredient.is_garnish == true
      assert recipe_ingredient.is_optional == true
      assert recipe_ingredient.unit == "some unit"
    end

    test "create_recipe_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe_ingredient(@invalid_attrs)
    end

    test "update_recipe_ingredient/2 with valid data updates the recipe_ingredient" do
      recipe_ingredient = recipe_ingredient_fixture()
      assert {:ok, %RecipeIngredient{} = recipe_ingredient} = Recipes.update_recipe_ingredient(recipe_ingredient, @update_attrs)
      assert recipe_ingredient.amount == Decimal.new("456.7")
      assert recipe_ingredient.ingredient == "some updated ingredient"
      assert recipe_ingredient.is_garnish == false
      assert recipe_ingredient.is_optional == false
      assert recipe_ingredient.unit == "some updated unit"
    end

    test "update_recipe_ingredient/2 with invalid data returns error changeset" do
      recipe_ingredient = recipe_ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe_ingredient(recipe_ingredient, @invalid_attrs)
      assert recipe_ingredient == Recipes.get_recipe_ingredient!(recipe_ingredient.id)
    end

    test "delete_recipe_ingredient/1 deletes the recipe_ingredient" do
      recipe_ingredient = recipe_ingredient_fixture()
      assert {:ok, %RecipeIngredient{}} = Recipes.delete_recipe_ingredient(recipe_ingredient)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe_ingredient!(recipe_ingredient.id) end
    end

    test "change_recipe_ingredient/1 returns a recipe_ingredient changeset" do
      recipe_ingredient = recipe_ingredient_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe_ingredient(recipe_ingredient)
    end
  end

  describe "tags" do
    alias Drunkard.Recipes.Tag

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Recipes.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Recipes.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Recipes.create_tag(@valid_attrs)
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Recipes.update_tag(tag, @update_attrs)
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_tag(tag, @invalid_attrs)
      assert tag == Recipes.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Recipes.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Recipes.change_tag(tag)
    end
  end
end
