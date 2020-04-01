defmodule HlsMockWeb.HealthCheckController do
  use HlsMockWeb, :controller

  def index(conn, _params) do
    conn
    |> Plug.Conn.send_resp(200, "OK")
  end
end