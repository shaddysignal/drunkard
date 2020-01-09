defmodule Drunkard.Recipes do
  @moduledoc """
  The Recipes context.
  """

  import Ecto.Query, warn: false
  alias Drunkard.Repo
  alias Drunkard.Recipes.Slug

  alias Drunkard.Recipes.Ingredient

  @doc """
  Returns the list of ingredients.

  ## Examples

      iex> list_ingredients()
      [%Ingredient{}, ...]

  """
  def list_ingredients, do: Repo.all(Ingredient)
  def list_ingredients(preload_fields) do
    Repo.all(Ingredient) |> Enum.map(fn i -> ingredient_preload(i, preload_fields) end)
  end

  @doc """
  Gets a single ingredient.

  Raises `Ecto.NoResultsError` if the Ingredient does not exist.

  ## Examples

      iex> get_ingredient!(123)
      %Ingredient{}

      iex> get_ingredient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ingredient!(%{uuid: uuid}), do: Repo.get!(Ingredient, uuid)
  def get_ingredient!(%{name: name}), do: Repo.get_by!(Ingredient, name: name)

  def get_ingredients_and_preload!(%{name_part: name_part}) do
    Repo.all(from i in Ingredient, where: ilike(i.name, ^"%#{name_part}%"), preload: [:icon, :image, :alternatives, :tags])
  end
  def get_ingredients_and_preload!(names) do
    Repo.all(from i in Ingredient, where: i.name in ^names, preload: [:icon, :image, :alternatives, :tags])
  end
  def get_ingredients_and_preload!(names, preload_fields) do
    Repo.all(from i in Ingredient, where: i.name in ^names, preload: ^preload_fields)
  end

  def ingredient_preload(ingredient, preload_fields) do
    Repo.preload(ingredient, preload_fields)
  end

  @doc """
  Creates a ingredient.

  ## Examples

      iex> create_ingredient(%{field: value})
      {:ok, %Ingredient{}}

      iex> create_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ingredient(attrs \\ %{}) do
    %Ingredient{}
    |> Ingredient.changeset(attrs)
    |> Repo.insert()
  end

  def create_ingredient!(attrs \\ %{}) do
    %Ingredient{}
    |> Ingredient.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a ingredient.

  ## Examples

      iex> update_ingredient(ingredient, %{field: new_value})
      {:ok, %Ingredient{}}

      iex> update_ingredient(ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> Ingredient.changeset(attrs)
    |> Repo.update()
  end

  def update_ingredient!(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> Ingredient.changeset(attrs)
    |> Repo.update!()
  end

  @doc """
  Deletes a Ingredient.

  ## Examples

      iex> delete_ingredient(ingredient)
      {:ok, %Ingredient{}}

      iex> delete_ingredient(ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient(%Ingredient{} = ingredient) do
    Repo.delete(ingredient)
  end

  def delete_ingredient!(%Ingredient{} = ingredient) do
    Repo.delete!(ingredient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient changes.

  ## Examples

      iex> change_ingredient(ingredient)
      %Ecto.Changeset{source: %Ingredient{}}

  """
  def change_ingredient(%Ingredient{} = ingredient) do
    Ingredient.changeset(ingredient, %{})
  end

  alias Drunkard.Recipes.IngredientToIngredient

  def create_ingredient_ingredient_link!(attrs) do
    %IngredientToIngredient{}
    |> IngredientToIngredient.changeset(attrs)
    |> Repo.insert!()
  end

  alias Drunkard.Recipes.Glass

  @doc """
  Returns the list of glasses.

  ## Examples

      iex> list_glasses()
      [%Glass{}, ...]

  """
  def list_glasses do
    Repo.all(Glass)
  end

  @doc """
  Gets a single glass.

  Raises `Ecto.NoResultsError` if the Glass does not exist.

  ## Examples

      iex> get_glass!(123)
      %Glass{}

      iex> get_glass!(456)
      ** (Ecto.NoResultsError)

  """
  def get_glass!(%{uuid: uuid}), do: Repo.get!(Glass, uuid)
  def get_glass!(%{name: name}), do: Repo.get_by!(Glass, name: name)

  def get_glasses_and_preload!(%{name_part: name_part}) do
    Repo.all(from g in Glass, where: ilike(g.name, ^"%#{name_part}%"), preload: [:icon, :image, :recipes])
  end

  def glass_preload(glass, preload_fields) do
    Repo.preload(glass, preload_fields)
  end

  @doc """
  Creates a glass.

  ## Examples

      iex> create_glass(%{field: value})
      {:ok, %Glass{}}

      iex> create_glass(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_glass(attrs \\ %{}) do
    %Glass{}
    |> Glass.changeset(attrs)
    |> Repo.insert()
  end

  def create_glass!(attrs \\ %{}) do
    %Glass{}
    |> Glass.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a glass.

  ## Examples

      iex> update_glass(glass, %{field: new_value})
      {:ok, %Glass{}}

      iex> update_glass(glass, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_glass(%Glass{} = glass, attrs) do
    glass
    |> Glass.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Glass.

  ## Examples

      iex> delete_glass(glass)
      {:ok, %Glass{}}

      iex> delete_glass(glass)
      {:error, %Ecto.Changeset{}}

  """
  def delete_glass(%Glass{} = glass) do
    Repo.delete(glass)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking glass changes.

  ## Examples

      iex> change_glass(glass)
      %Ecto.Changeset{source: %Glass{}}

  """
  def change_glass(%Glass{} = glass) do
    Glass.changeset(glass, %{})
  end

  alias Drunkard.Recipes.Recipe

  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes do
    Repo.all(Recipe)
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

      iex> get_recipe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(%{uuid: uuid}), do: Repo.get!(Recipe, uuid)
  def get_recipe!(%{name: name}), do: Repo.get_by!(Recipe, name: name)

  def get_random_recipe!(), do: Repo.all(from r in Recipe, order_by: fragment("random()"), limit: 1) |> Enum.at(0)

  def get_recipes_and_preload!(%{name_part: name_part}) do
    Repo.all(from r in Recipe, where: ilike(r.name, ^"%#{name_part}%"), preload: [:icon, :image, :glass, :tags])
  end

  def get_recipes_by_ingredient_preload!(%{ingredient_uuid: iuuid, preload_fields: preload_fields}) do
    Repo.all(from r in Recipe,
              where: fragment(
                "? @> ? or ? @> ?",
                r.recipe_ingredients,
                ^[%{ingredient: iuuid}],
                r.recipe_ingredients,
                ^[%{alternatives: [iuuid]}]
              ),
              preload: ^preload_fields
    )
  end
  def get_recipes_by_ingredient_preload!(%{ingredient_uuid: _iuuid} = params) do
    get_recipes_by_ingredient_preload!(Map.put(params, :preload_fields, [:icon, :image, :glass, :tags]))
  end

  def get_recipes_by_ingredients_preload!(%{ingredient_uuids: ingredient_uuids, preload_fields: preload_fields}) do
    Repo.all(from r in Recipe,
              join: iv in fragment("jsonb_array_elements(?)", r.ingredient_variations), on: true,
              where: fragment(
                "? @> ?",
                ^ingredient_uuids,
                iv
              ),
              group_by: r.uuid,
              preload: ^preload_fields
    )
  end
  def get_recipes_by_ingredients_preload!(%{ingredient_uuids: _ingredient_uuids} = params) do
    get_recipes_by_ingredients_preload!(Map.put(params, :preload_fields, [:icon, :image, :glass, :tags]))
  end

  def recipe_preload(recipe, preload_fields) do
    Repo.preload(recipe, preload_fields)
  end

  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  def create_recipe!(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> change_recipe(recipe)
      %Ecto.Changeset{source: %Recipe{}}

  """
  def change_recipe(%Recipe{} = recipe) do
    Recipe.changeset(recipe, %{})
  end

  alias Drunkard.Recipes.Tag

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(%{uuid: uuid}), do: Repo.get!(Tag, uuid)
  def get_tag!(%{name: name}), do: Repo.get_by!(Tag, name: name)

  def get_tag_by_name(name) do
    Repo.all(from t in Tag, where: t.name == ^name)
  end

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{source: %Tag{}}

  """
  def change_tag(%Tag{} = tag) do
    Tag.changeset(tag, %{})
  end
end
