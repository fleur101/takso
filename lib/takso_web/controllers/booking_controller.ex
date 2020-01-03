defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, _param) do
    conn
    |> put_flash(:info, "Your taxi will arrive in 5 minutes")
    |> redirect(to: booking_path(conn, :new))
  end
end

