defmodule KV.Comment do
  use Agent
  use Timex

  def start_link(initial_map \\ %{}) do
    Agent.start(fn -> initial_map end, name: __MODULE__)
  end

  def make_comment(username, message) do
    now = Timex.now("Japan")

    %{
      :username => username,
      :message => message,
      :time => now
    }
  end

  def add(username, message \\ "") do
    Agent.update(__MODULE__, fn state ->
      state
      |> Map.update(username, [make_comment(username, message)], fn x ->
        [make_comment(username, message) | x]
      end)
    end)
  end

  def get(username) do
    Agent.get(__MODULE__, fn state -> state |> Map.get(username, 0) end)
  end

  def all() do
    Agent.get(__MODULE__, fn state ->
      state
      |> Enum.reduce([], fn {_username, comments}, acc ->
        acc ++ comments
      end)
      |> IO.inspect()
      |> Enum.sort(&(Timex.compare(&1.time, &2.time) == -1))
      |> Enum.map(fn x ->
        {:ok, relative_str} = x.time |> Timex.format("{relative}", :relative)
        Map.put(x, :relative_str, relative_str)
      end)
    end)
  end

  def delete_all() do
    Agent.update(__MODULE__, fn _state -> %{} end)
  end

  def explosion() do
    exit("黒より黒く...!")
  end
end
