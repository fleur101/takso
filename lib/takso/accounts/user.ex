defmodule Takso.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string
    has_many :bookings, Takso.Sales.Booking
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :password])
    |> validate_required([:name, :username, :password ])
  end
end
