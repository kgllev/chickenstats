defmodule Api.EventTest do
  use Api.DataCase

  alias Api.Event

  describe "chicken_runners" do
    alias Api.Event.ChickenRunner

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def chicken_runner_fixture(attrs \\ %{}) do
      {:ok, chicken_runner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Event.create_chicken_runner()

      chicken_runner
    end

    test "list_chicken_runners/0 returns all chicken_runners" do
      chicken_runner = chicken_runner_fixture()
      assert Event.list_chicken_runners() == [chicken_runner]
    end

    test "get_chicken_runner!/1 returns the chicken_runner with given id" do
      chicken_runner = chicken_runner_fixture()
      assert Event.get_chicken_runner!(chicken_runner.id) == chicken_runner
    end

    test "create_chicken_runner/1 with valid data creates a chicken_runner" do
      assert {:ok, %ChickenRunner{} = chicken_runner} = Event.create_chicken_runner(@valid_attrs)
    end

    test "create_chicken_runner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Event.create_chicken_runner(@invalid_attrs)
    end

    test "update_chicken_runner/2 with valid data updates the chicken_runner" do
      chicken_runner = chicken_runner_fixture()
      assert {:ok, %ChickenRunner{} = chicken_runner} = Event.update_chicken_runner(chicken_runner, @update_attrs)
    end

    test "update_chicken_runner/2 with invalid data returns error changeset" do
      chicken_runner = chicken_runner_fixture()
      assert {:error, %Ecto.Changeset{}} = Event.update_chicken_runner(chicken_runner, @invalid_attrs)
      assert chicken_runner == Event.get_chicken_runner!(chicken_runner.id)
    end

    test "delete_chicken_runner/1 deletes the chicken_runner" do
      chicken_runner = chicken_runner_fixture()
      assert {:ok, %ChickenRunner{}} = Event.delete_chicken_runner(chicken_runner)
      assert_raise Ecto.NoResultsError, fn -> Event.get_chicken_runner!(chicken_runner.id) end
    end

    test "change_chicken_runner/1 returns a chicken_runner changeset" do
      chicken_runner = chicken_runner_fixture()
      assert %Ecto.Changeset{} = Event.change_chicken_runner(chicken_runner)
    end
  end
end
