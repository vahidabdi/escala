defmodule EscalaDb.UserResolver do
  @moduledoc """
  User Resolver used by GraphQL
  """
  alias EscalaDb.Accounts

  def current_user(_args, %{context: %{current_user: %{id: id}}}) do
    case Accounts.get_user(id) do
      nil ->
        {:error, "User not found"}
      user ->
        {:ok, user}
    end
  end
  def current_user(_args, _info) do
    {:error, %{message: "login required", status: 401}}
  end
end
