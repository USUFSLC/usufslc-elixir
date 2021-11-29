defmodule Fslc.RicesTest do
  use Fslc.DataCase

  alias Fslc.Rices

  describe "rices" do
    alias Fslc.Rices.Rice

    @valid_attrs %{description: "some description", document_id: 42, name: "some name", user_id: 42}
    @update_attrs %{description: "some updated description", document_id: 43, name: "some updated name", user_id: 43}
    @invalid_attrs %{description: nil, document_id: nil, name: nil, user_id: nil}

    def rice_fixture(attrs \\ %{}) do
      {:ok, rice} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rices.create_rice()

      rice
    end

    test "list_rices/0 returns all rices" do
      rice = rice_fixture()
      assert Rices.list_rices() == [rice]
    end

    test "get_rice!/1 returns the rice with given id" do
      rice = rice_fixture()
      assert Rices.get_rice!(rice.id) == rice
    end

    test "create_rice/1 with valid data creates a rice" do
      assert {:ok, %Rice{} = rice} = Rices.create_rice(@valid_attrs)
      assert rice.description == "some description"
      assert rice.document_id == 42
      assert rice.name == "some name"
      assert rice.user_id == 42
    end

    test "create_rice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rices.create_rice(@invalid_attrs)
    end

    test "update_rice/2 with valid data updates the rice" do
      rice = rice_fixture()
      assert {:ok, %Rice{} = rice} = Rices.update_rice(rice, @update_attrs)
      assert rice.description == "some updated description"
      assert rice.document_id == 43
      assert rice.name == "some updated name"
      assert rice.user_id == 43
    end

    test "update_rice/2 with invalid data returns error changeset" do
      rice = rice_fixture()
      assert {:error, %Ecto.Changeset{}} = Rices.update_rice(rice, @invalid_attrs)
      assert rice == Rices.get_rice!(rice.id)
    end

    test "delete_rice/1 deletes the rice" do
      rice = rice_fixture()
      assert {:ok, %Rice{}} = Rices.delete_rice(rice)
      assert_raise Ecto.NoResultsError, fn -> Rices.get_rice!(rice.id) end
    end

    test "change_rice/1 returns a rice changeset" do
      rice = rice_fixture()
      assert %Ecto.Changeset{} = Rices.change_rice(rice)
    end
  end
end
