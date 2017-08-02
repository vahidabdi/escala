defmodule EscalaApiWeb.UserResolverTest do
  @moduledoc """
  UserResolver Test module
  """
  use EscalaDb.DbCase
  use EscalaApiWeb.ConnCase

  alias EscalaDb.Accounts
  alias EscalaApiWeb.AbsintheHelpers

  @user %{email: "test@gmail.com", providers: ["google"]}

  setup do
    {:ok, user} = Accounts.create_user(@user)
    assert {:ok, token, _} = Guardian.encode_and_sign(user)

    conn = build_conn()
        |> put_req_header("authorization", "Bearer #{token}")
        |> put_req_header("content-type", "application/json")

    {:ok, %{conn: conn, user: user}}
  end


  describe "User Resolver" do
    test "Logged in user should see their email", context do

      query = """
      {
        currentUser {
          email
        }
      }
      """

      res = context.conn
        |> post("/", AbsintheHelpers.query_skeleton(query, "currentUser"))

      assert json_response(res, 200)["data"]["currentUser"]["email"] == context.user.email
    end
  end
end
