defmodule HlsMockWeb.MediaSequence do
  use Agent

  def start_link() do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end

  def increment do
    Agent.update(__MODULE__, &(&1 + 1))
  end
end

defmodule HlsMockWeb.MediaSequence.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      HlsMockWeb.MediaSequence
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end