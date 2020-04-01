defmodule HlsMockWeb.Playlist do

  @playlist_length 4

  def start_link() do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def drive() do
    HlsMockWeb.MediaSequence.increment()
    counter = HlsMockWeb.MediaSequence.get()

    ts = rem(counter, @playlist_length) + 1
    template = "#EXT-INF:2.00,\n/ts/seg-#{ts}.ts\n"
    Agent.update(__MODULE__, fn list -> [template | list] end)
    if ts == @playlist_length do
      Agent.update(__MODULE__, fn list -> ["#EXT-X-DISCONTINUITY\n" | list] end)
    end

    Process.sleep(1000)
    drive()
  end

  def get() do
    got = Agent.get(__MODULE__, fn list -> list end)
    got
  end
end

defmodule HlsMockWeb.Playlist.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      HlsMockWeb.Playlist
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end