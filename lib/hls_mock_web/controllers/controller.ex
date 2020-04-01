defmodule HlsMockWeb.Controller do
  use HlsMockWeb, :controller
  import Poison

  @data_dir "data/"

  def get_playlist(conn, _params) do
    p = HlsMockWeb.Playlist.get()
    counter = HlsMockWeb.MediaSequence.get()
    m = ["#EXTM3U\n#EXT-X-VERSION:3\n#EXT-X-ALLOW-CACHE:NO\n#EXT-X-TARGETDURATION:2\n#EXT-X-MEDIA-SEQUENCE:#{counter}\n"]
    updated = [m | p]
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/x-mpegURL")
    |> Plug.Conn.resp(200, updated)
    |> Plug.Conn.send_resp()
  end

  def get_file(conn, %{"id" => id}) do
    file =  @data_dir <> "seg-" <> id <> ".ts"
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/x-mpegURL")
    |> Plug.Conn.send_file(200, file)
  end

  def send_json(conn, data, pretty) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json; charset=utf-8")
    |> Plug.Conn.send_resp(200, Poison.encode!(data, pretty: pretty))
  end
end