defmodule ApiWeb.ChickenRunnerControllerTest do
  use ApiWeb.ConnCase

  alias Api.Event
  alias Api.Event.ChickenRunner

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:chicken_runner) do
    {:ok, chicken_runner} = Event.create_chicken_runner(@create_attrs)
    chicken_runner
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all chicken_runners", %{conn: conn} do
      conn = get(conn, Routes.chicken_runner_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create chicken_runner" do
    test "renders chicken_runner when data is valid", %{conn: conn} do
      conn = post(conn, Routes.chicken_runner_path(conn, :create), chicken_runner: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.chicken_runner_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.chicken_runner_path(conn, :create), chicken_runner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update chicken_runner" do
    setup [:create_chicken_runner]

    test "renders chicken_runner when data is valid", %{conn: conn, chicken_runner: %ChickenRunner{id: id} = chicken_runner} do
      conn = put(conn, Routes.chicken_runner_path(conn, :update, chicken_runner), chicken_runner: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.chicken_runner_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, chicken_runner: chicken_runner} do
      conn = put(conn, Routes.chicken_runner_path(conn, :update, chicken_runner), chicken_runner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete chicken_runner" do
    setup [:create_chicken_runner]

    test "deletes chosen chicken_runner", %{conn: conn, chicken_runner: chicken_runner} do
      conn = delete(conn, Routes.chicken_runner_path(conn, :delete, chicken_runner))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.chicken_runner_path(conn, :show, chicken_runner))
      end
    end
  end

  defp create_chicken_runner(_) do
    chicken_runner = fixture(:chicken_runner)
    %{chicken_runner: chicken_runner}
  end
end
