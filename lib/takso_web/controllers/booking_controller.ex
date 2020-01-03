defmodule TaksoWeb.BookingController do
  use TaksoWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Takso.{Repo, Sales.Taxi, Sales.Booking}

  def new(conn, _params) do
    changeset = Booking.changeset(%Booking{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"booking" => booking_params}) do
    user = conn.assigns.current_user

    booking_struct = Ecto.build_assoc(user, :bookings, Enum.map(booking_params, fn({key, value}) -> {String.to_atom(key), value} end))
    Repo.insert(booking_struct)

    query = from t in Taxi, where: t.status == "available", select: t
    available_taxis = Repo.all(query)

    case length(available_taxis) > 0 do
      true -> conn
        |> put_flash(:info, "Your taxi will arrive in 5 minutes")
        |> redirect(to: booking_path(conn, :new))
      _    -> conn
        |> put_flash(:info, "At present, there is no taxi available!")
        |> redirect(to: booking_path(conn, :new))
    end
  end
end

