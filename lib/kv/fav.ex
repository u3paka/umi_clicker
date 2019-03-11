defmodule KV.Fav do
  use Agent

  def start_link(initial_map \\ %{}) do
    Agent.start(fn -> initial_map end, name: __MODULE__)
  end

  def add(user, count \\ 1) do
    Agent.update(__MODULE__, fn state -> state |> Map.update(user, 1, fn x -> x + count end) end)
  end

  def get(user) do
    Agent.get(__MODULE__, fn state -> state |> Map.get(user, 0) end)
  end

  def get_sum() do
    Agent.get(__MODULE__, fn state ->
      state
      |> Enum.reduce(0, fn {_user, x}, acc ->
        acc + x
      end)
    end)
  end

  def explosion() do
    exit("詠唱魔法!! 黒より黒く...!!!")
  end
end
