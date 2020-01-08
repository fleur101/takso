defmodule TaksoWeb.TaxiControllerTest do
  use TaksoWeb.ConnCase
  alias Takso.{Repo,Sales.Taxi}
  alias Takso.Guardian
  alias Takso.Accounts.User

  setup do
    user = Repo.get!(User, 1)
    conn = build_conn()
           |> bypass_through(Takso.Router, [:browser, :browser_auth, :ensure_auth])
           |> get("/")
           |> Map.update!(:state, fn (_) -> :set end)
           |> Guardian.Plug.sign_in(user)
           |> send_resp(200, "Flush the session")
           |> recycle
    changeset = Taxi.changeset(%Taxi{}, %{username: "jamesMcAvoy", location: "Raatuse 22, Tartu", status: "OPEN"})
    taxi = Repo.insert!(changeset)
    {:ok, conn: conn}
  end

  test 'show available taxis', %{conn: conn} do
    conn = get conn, "/taxis"
    assert html_response(conn, 200) =~ ~r/jamesMcAvoy/
  end
end
