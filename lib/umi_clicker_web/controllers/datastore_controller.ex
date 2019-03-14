defmodule UmiClickerWeb.DataStoreController do
  use UmiClickerWeb, :controller

  def dump(conn, _params) do
    render(conn, "data.json")
  end

  def restore(conn, %{"data" => data}), do: restore(conn, data)

  def restore(conn, params) when is_bitstring(params) do
    case Jason.decode(params) do
      {:ok, params_map} ->
        restore(conn, params_map)

      {:error, %Jason.DecodeError{position: pos}} ->
        json(conn, %{
          "result" => "error",
          "pos" => pos
        })
    end
  end

  def restore(conn, %{"comment" => comments, "fav" => favs} = params) do
    KV.Fav.restore(favs)
    KV.Comment.restore(comments)
    KV.Comment.upgrade()

    json(conn, %{
      "status" => "ok"
    })
  end

  def restore(conn, params) do
    IO.inspect(params)

    json(conn, %{
      "status" => "ok"
    })
  end

  def restore_form(conn, _params) do
    render(conn, "restore.html", changeset: %{})
  end
end
