defmodule EscalaDb.UserResolverTest do
  @moduledoc """
  UserResolver Test module
  """
  use EscalaDb.SchemaCase

  alias EscalaDb.Accounts

  describe "UserResolver" do
    @query """
    query {
      currentUser {
        id
        email
      }
    }
    """
    test "get current_user with valid info on context returns user data" do
      assert {:ok, user} = Accounts.create_user(%{email: "test@email.com", providers: ["google"]})
      assert {:ok, data} = Absinthe.run(@query, EscalaDb.Schema, context: %{current_user: %{id: user.id}})
      assert data.data["currentUser"]["email"] == "test@email.com"
    end

    test "get current_user without current_user context return error with status 401" do
      assert {:ok, %{errors: error}} = Absinthe.run(@query, EscalaDb.Schema)
      [res] = error
      assert res.status == 401
    end
  end
end
