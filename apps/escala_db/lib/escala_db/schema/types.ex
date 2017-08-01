defmodule EscalaDb.Schema.Types do
  @moduledoc """
  GraphQL Schema Types
  """
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :email, :string
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :picture, :string
  end

  object :session do
    field :token, :string
  end
end
