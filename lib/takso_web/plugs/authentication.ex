defmodule Takso.Authentication do
  import Plug.Conn
  def init(opts) do
    opts[:repo]
  end
  def call(conn, repo) do
    IO.puts "HI THERE ..."
    user = repo.get(Takso.Accounts.User, 1)
    assign(conn, :current_user, user)
  end
end

