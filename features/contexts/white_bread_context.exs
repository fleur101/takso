defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers
  alias Takso.{Repo,Sales.Taxi}

  feature_starting_state fn  ->
    Application.ensure_all_started(:hound)
    %{}
  end

  scenario_starting_state fn _state ->
    Hound.start_session
    Ecto.Adapters.SQL.Sandbox.checkout(Takso.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Takso.Repo, {:shared, self()})
    %{}
  end

  scenario_finalize fn _status, _state ->
    Ecto.Adapters.SQL.Sandbox.checkin(Takso.Repo)
    # Hound.end_session
  end

  given_ ~r/^I want to login with username "(?<username>[^"]+)" and password "(?<password>[^"]+)"$/,
  fn state, %{username: username, password: password} ->
    {:ok, state |> Map.put(:username, username) |> Map.put(:password, password)}
  end

  and_ ~r/^I open login page$/, fn state ->
    navigate_to "/sessions/new"
    {:ok, state}
  end

  and_ ~r/^I enter login information$/, fn state ->
    fill_field({:id, "session_username"}, state[:username])
    fill_field({:id, "session_password"}, state[:password])
    {:ok, state}
  end

  when_ ~r/^I submit the login request$/, fn state ->
    click({:id, "submit_button"})
    {:ok, state}
  end

  then_ ~r/^I should receive a greeting message$/, fn state ->
    assert visible_in_page? ~r/Welcome/
    {:ok, state}
  end

  given_ ~r/^the following taxis are on duty$/, fn state, %{table_data: table} ->
    table
    |> Enum.map(fn taxi -> Taxi.changeset(%Taxi{}, taxi) end)
    |> Enum.each(fn changeset -> Repo.insert!(changeset) end)
    {:ok, state}
  end

  and_ ~r/^I want to go from "(?<pickup_address>[^"]+)" to "(?<dropoff_address>[^"]+)"$/,
  fn state, %{pickup_address: pickup_address, dropoff_address: dropoff_address} ->
    {:ok, state |> Map.put(:pickup_address, pickup_address) |> Map.put(:dropoff_address, dropoff_address)}
  end

  and_ ~r/^I open STRS' web page$/, fn state ->
    navigate_to "/bookings/new"
    {:ok, state}
  end

  and_ ~r/^I enter the booking information$/, fn state ->
    fill_field({:id, "booking_pickup_address"}, state[:pickup_address])
    fill_field({:id, "booking_dropoff_address"}, state[:dropoff_address])
    {:ok, state}
  end

  when_ ~r/^I submit the booking request$/, fn state ->
    click({:id, "submit_button"})
    {:ok, state}
  end

  then_ ~r/^I see a list of available taxis with full names "(?<driver1>[^"]+)" and "(?<driver2>[^"]+)"$/,
  fn state, %{driver1: driver1, driver2: driver2} ->
    {:ok, state}
  end

  and_ ~r/^I select "(?<driver1>[^"]+)" and "(?<driver2>[^"]+)"$/,
  fn state, %{driver1: driver1, driver2: driver2} ->
    {:ok, state}
  end

  when_ ~r/^I submit the taxi request$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I see a list of selected taxis$/, fn state ->
    {:ok, state}
  end

  given_ ~r/^"(?<driver1>[^"]+)" first accepts booking$/,
  fn state, %{driver1: driver1} ->
    {:ok, state}
  end

  and_ ~r/^I refresh page$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I see my booking accepted by "(?<driver1>[^"]+)"$/,
  fn state, %{driver1: driver1} ->
    {:ok, state}
  end

  # then_ ~r/^I should receive a rejection message$/, fn state ->
  #   assert visible_in_page? ~r/At present, there is no taxi available!/
  #   {:ok, state}
  # end


end
