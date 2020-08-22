defmodule CrossingWeb.PageController do
  use CrossingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
