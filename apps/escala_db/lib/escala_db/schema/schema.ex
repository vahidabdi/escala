defmodule EscalaDb.Schema do
  @moduledoc """
  GraphQL Schema
  """
  use Absinthe.Schema

  import_types EscalaDb.Schema.Types
  alias EscalaDb.{UserResolver}

  query do
    @desc "Get current_user user"
    field :current_user, type: :user do
      resolve &UserResolver.current_user/2
    end
  end
end
