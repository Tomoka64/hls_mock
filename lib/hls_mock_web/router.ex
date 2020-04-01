defmodule HlsMockWeb.Router do
  use HlsMockWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HlsMockWeb do
    pipe_through :api
    get("/", HealthCheckController, :index)
  end

  scope "/api", HlsMockWeb do
    pipe_through :api

    get("/:id", Controller, :get_file)
    get("/m3u8/playlist.m3u8", Controller, :get_playlist)
  end
end
