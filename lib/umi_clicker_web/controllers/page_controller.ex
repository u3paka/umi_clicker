defmodule UmiClickerWeb.PageController do
  use UmiClickerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
