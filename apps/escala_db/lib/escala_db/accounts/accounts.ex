defmodule EscalaDb.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias EscalaDb.Repo

  alias EscalaDb.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user or returns nil if user does not exist.

  ## Examples

      iex> get_user("457f4850-2716-4541-812c-30b58fac2153")
      %User{}

      iex> get_user("457f4850-2716-4541-812c-30b58fac2151")
      nil

  """
  def get_user(id) do
    case Ecto.UUID.cast(id) do
      {:ok, id} ->
        Repo.get(User, id)
      _ ->
        nil
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
