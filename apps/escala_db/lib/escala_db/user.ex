defmodule EscalaDb.User do
  @moduledoc """
  User schema
  """
  use Ecto.Schema

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
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
    |> Changeset.cast(params, [
        :email, :username, :first_name, :last_name, :picture, :providers, :meta]
      )
    |> Changeset.validate_required([:email, :providers])
    |> Changeset.unique_constraint(:email)
    |> Changeset.unique_constraint(:username)
  end
end
