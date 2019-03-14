defmodule UmiClickerWeb.DataStoreView do
  use UmiClickerWeb, :view

  def render("data.json", _assign) do
    favs = KV.Fav.all()
    comments = KV.Comment.all()
    %{fav: favs,
      comment: comments}
  end
end
