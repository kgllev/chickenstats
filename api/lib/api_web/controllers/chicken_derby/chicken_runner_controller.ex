defmodule ApiWeb.ChickenDerby.ChickenRunnerController do
  use ApiWeb, :controller

  alias Api.Event
  alias Api.Event.ChickenRunner
  alias ApiWeb.ChickenDerby.ChickenRunnerView

  action_fallback ApiWeb.FallbackController

  def index(conn, %{"page" => page, "filters" => filters, "limit" => limit}) do
    limit = String.to_integer(limit)
    page = String.to_integer(page)
    %{results: chicken_runners, stats: stats} = Event.list_chicken_runners(page, limit, filters)
    render(conn, "index.json", chicken_runners: chicken_runners, stats: stats)
  end

  def create(conn, %{"chicken_runner" => %{"event_id" => event_id} =  chicken_runner_params}) do
    case Event.get_chicken_runner_by_event_id(event_id) do
      nil ->
        {:ok, chicken_runner} = chicken_runner_params
                                |> Event.create_chicken_runner()
        ApiWeb.Endpoint.broadcast(
          "chicken_derby",
          "derbies",
          Phoenix.View.render(ChickenRunnerView, "chicken_runner.json", %{chicken_runner: chicken_runner})
        )
        render(conn, "show.json", chicken_runner: chicken_runner)
      chicken_runner ->
        send_resp(conn, :no_content, "")
    end
  end

  def show(conn, %{"id" => id}) do
    chicken_runner = Event.get_chicken_runner!(id)
    render(conn, "show.json", chicken_runner: chicken_runner)
  end

  def update(conn, %{"id" => id, "chicken_runner" => chicken_runner_params}) do
    chicken_runner = Event.get_chicken_runner!(id)

    with {:ok, %ChickenRunner{} = chicken_runner} <- Event.update_chicken_runner(chicken_runner, chicken_runner_params) do
      render(conn, "show.json", chicken_runner: chicken_runner)
    end
  end

  def delete(conn, %{"id" => id}) do
    chicken_runner = Event.get_chicken_runner!(id)

    with {:ok, %ChickenRunner{}} <- Event.delete_chicken_runner(chicken_runner) do
      send_resp(conn, :no_content, "")
    end
  end
end
