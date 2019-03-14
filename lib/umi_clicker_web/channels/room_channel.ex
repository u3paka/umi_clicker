defmodule UmiClickerWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:chat", payload, socket) do

    sum = KV.Fav.get_sum()
    user_sum = KV.Fav.get(payload["user"])
    fav = %{
      :sum => sum,
      :user => payload["user"],
      :user_sum => user_sum
    }
    {:ok, %{:timeline => KV.Comment.all(), :fav => fav}, socket}
  end

  def handle_in("new_comment", %{"comment" => %{"username" => username, "message" => message} = comment}, socket) do
    KV.Comment.add(username, message)

    result = %{
      :new_comment => comment,
      :timeline => KV.Comment.all()
    }
    broadcast!(socket, "new_comment_added", result)
    {:noreply, socket}
  end

  def handle_in("new_click", payload, socket) do
    KV.Fav.add(payload["user"], payload["count"])
    sum = KV.Fav.get_sum()
    user_sum = KV.Fav.get(payload["user"])

    result = %{
      :sum => sum,
      :user => payload["user"],
      :user_sum => user_sum
    }
    broadcast!(socket, "new_click_added", result)
    {:noreply, socket}
  end

  def handle_in("explosion", _payload, socket) do
    KV.Fav.explosion()
    {:noreply, socket}
  end
  def handle_out("new_comment", payload, socket) do
    push socket, "new_comment", payload
    {:noreply, socket}
  end

  def handle_out("new_click", payload, socket) do
    push socket, "new_click", payload
    {:noreply, socket}
  end
end
