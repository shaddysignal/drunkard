defmodule DrunkardWeb.GlassControllerTest do
  use DrunkardWeb.ConnCase

  alias Drunkard.Recipes

  @create_attrs %{desc: "some desc", image_path: "some image_path", name: "some name"}
  @update_attrs %{desc: "some updated desc", image_path: "some updated image_path", name: "some updated name"}
  @invalid_attrs %{desc: nil, image_path: nil, name: nil}

  def fixture(:glass) do
    {:ok, glass} = Recipes.create_glass(@create_attrs)
    glass
  end

  describe "index" do
    test "lists all glasses", %{conn: conn} do
      conn = get(conn, Routes.glass_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Glasses"
    end
  end

  describe "new glass" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.glass_path(conn, :new))
      assert html_response(conn, 200) =~ "New Glass"
    end
  end

  describe "create glass" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.glass_path(conn, :create), glass: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.glass_path(conn, :show, id)

      conn = get(conn, Routes.glass_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Glass"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.glass_path(conn, :create), glass: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Glass"
    end
  end

  describe "edit glass" do
    setup [:create_glass]

    test "renders form for editing chosen glass", %{conn: conn, glass: glass} do
      conn = get(conn, Routes.glass_path(conn, :edit, glass))
      assert html_response(conn, 200) =~ "Edit Glass"
    end
  end

  describe "update glass" do
    setup [:create_glass]

    test "redirects when data is valid", %{conn: conn, glass: glass} do
      conn = put(conn, Routes.glass_path(conn, :update, glass), glass: @update_attrs)
      assert redirected_to(conn) == Routes.glass_path(conn, :show, glass)

      conn = get(conn, Routes.glass_path(conn, :show, glass))
      assert html_response(conn, 200) =~ "some updated desc"
    end

    test "renders errors when data is invalid", %{conn: conn, glass: glass} do
      conn = put(conn, Routes.glass_path(conn, :update, glass), glass: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Glass"
    end
  end

  describe "delete glass" do
    setup [:create_glass]

    test "deletes chosen glass", %{conn: conn, glass: glass} do
      conn = delete(conn, Routes.glass_path(conn, :delete, glass))
      assert redirected_to(conn) == Routes.glass_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.glass_path(conn, :show, glass))
      end
    end
  end

  defp create_glass(_) do
    glass = fixture(:glass)
    {:ok, glass: glass}
  end
end
