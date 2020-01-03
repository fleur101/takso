defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Takso.{Repo, Sales.Taxi}

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, _param) do
    query = from t in Taxi, where: t.status == "available", select: t
    available_taxis = Repo.all(query)
    if length(available_taxis) >0 do
        conn
        |> put_flash(:info, "Your taxi will arrive in 5 minutes")
        |> redirect(to: user_path(conn, :index))
    else
        conn
        |> put_flash(:info, "At present, there is no taxi available!")
        |> redirect(to: user_path(conn, :index))
    end

  end
end

