defmodule FslcWeb.RiceControllerTest do
  use FslcWeb.ConnCase

  alias Fslc.Rices

  @create_attrs %{description: "some description", document_id: 42, name: "some name", user_id: 42}
  @update_attrs %{description: "some updated description", document_id: 43, name: "some updated name", user_id: 43}
  @invalid_attrs %{description: nil, document_id: nil, name: nil, user_id: nil}

  def fixture(:rice) do
    {:ok, rice} = Rices.create_rice(@create_attrs)
    rice
  end

  describe "index" do
    test "lists all rices", %{conn: conn} do
      conn = get(conn, Routes.rice_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rices"
    end
  end

  describe "new rice" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.rice_path(conn, :new))
      assert html_response(conn, 200) =~ "New Rice"
    end
  end

  describe "create rice" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.rice_path(conn, :create), rice: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.rice_path(conn, :show, id)

      conn = get(conn, Routes.rice_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Rice"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.rice_path(conn, :create), rice: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Rice"
    end
  end

  describe "edit rice" do
    setup [:create_rice]

    test "renders form for editing chosen rice", %{conn: conn, rice: rice} do
      conn = get(conn, Routes.rice_path(conn, :edit, rice))
      assert html_response(conn, 200) =~ "Edit Rice"
    end
  end

  describe "update rice" do
    setup [:create_rice]

    test "redirects when data is valid", %{conn: conn, rice: rice} do
      conn = put(conn, Routes.rice_path(conn, :update, rice), rice: @update_attrs)
      assert redirected_to(conn) == Routes.rice_path(conn, :show, rice)

      conn = get(conn, Routes.rice_path(conn, :show, rice))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, rice: rice} do
      conn = put(conn, Routes.rice_path(conn, :update, rice), rice: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Rice"
    end
  end

  describe "delete rice" do
    setup [:create_rice]

    test "deletes chosen rice", %{conn: conn, rice: rice} do
      conn = delete(conn, Routes.rice_path(conn, :delete, rice))
      assert redirected_to(conn) == Routes.rice_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.rice_path(conn, :show, rice))
      end
    end
  end

  defp create_rice(_) do
    rice = fixture(:rice)
    %{rice: rice}
  end
end
