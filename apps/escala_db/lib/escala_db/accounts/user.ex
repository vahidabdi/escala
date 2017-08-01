defmodule EscalaDb.Accounts.User do
  @moduledoc """
  User schema
  """
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "accounts_users" do
    field :email, :string
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :picture, :string
    field :providers, {:array, :string}
    field :meta, :map

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [
        :email, :username, :first_name, :last_name, :picture, :providers, :meta]
      )
    |> validate_required([:email, :providers])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
