defmodule ApiWeb.DerbyChannel do
  use Phoenix.Channel

  def join("chicken_derby", _params, socket)do
    {:ok, socket}
  end

  def handle_in("derbies", data, socket)do
    broadcast!(socket, "derbies", data)
    {:noreply, socket}
  end
end