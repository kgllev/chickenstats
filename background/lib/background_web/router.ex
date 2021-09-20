defmodule BackgroundWeb.Router do
  use BackgroundWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BackgroundWeb do
    pipe_through :api
  end
end
