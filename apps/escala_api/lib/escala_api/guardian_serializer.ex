defmodule EscalaApi.GuardianSerializer do
  @moduledoc """
  Guardian Serializer
  """

  @behaviour Guardian.Serializer

  alias EscalaDb.Accounts
  alias EscalaDb.Accounts.User

  def for_token(%User{} = user), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("User:" <> id), do: {:ok, Accounts.get_user(id)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
