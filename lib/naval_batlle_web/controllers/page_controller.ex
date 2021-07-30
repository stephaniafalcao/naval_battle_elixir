defmodule NavalBatlleWeb.PageController do
  use NavalBatlleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
