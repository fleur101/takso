defmodule Takso.Authentication do
  def init(_opts), do: nil
  def call(conn, _) do
    IO.puts "HI THERE ..."
    conn
  end
end

