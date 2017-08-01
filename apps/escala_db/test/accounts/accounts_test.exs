defmodule EscalaDb.AccountsTest do
  @moduledoc """
  Accounts Test module
  """
  use EscalaDb.DbCase

  alias EscalaDb.Accounts

  describe "users" do
    alias EscalaDb.Accounts.User

    @valid_attrs %{
      email: "vanda@gmail.com", username: "vanda", first_name: "vahid",
      last_name: "abdi", picture: "http://google.com/profile.jpg",
      providers: ["google"],
      meta: %{"type" => "user"}
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert [user] == Accounts.list_users()
    end

    test "get_user/1 returns a signle user with valid id" do
      new_user = user_fixture()
      user = Accounts.get_user(new_user.id)
      assert user.id == new_user.id
    end

    test "get_user/1 returns nil user with invalid id" do
      assert nil == Accounts.get_user("invalid")
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "vanda@gmail.com"
      assert user.username == "vanda"
      assert user.first_name == "vahid"
      assert user.last_name == "abdi"
      assert user.picture == "http://google.com/profile.jpg"
      assert user.providers == ["google"]
      assert user.meta == %{"type" => "user"}
    end

    test "create_user/1 without email returns error changeset" do
      invalid_attrs = %{email: nil} |> Enum.into(@valid_attrs)
      assert {:error, changeset} = Accounts.create_user(invalid_attrs)
      assert "can't be blank" in errors_on(changeset).email
    end

    test "create_user/1 without providers returns error changeset" do
      invalid_attrs = %{providers: nil} |> Enum.into(@valid_attrs)
      assert {:error, changeset} = Accounts.create_user(invalid_attrs)
      assert "can't be blank" in errors_on(changeset).providers
    end

    test "create_user/1 with duplicate email returns error changeset" do
      assert {:ok, %User{}} = Accounts.create_user(@valid_attrs)
      assert {:error, changeset} = Accounts.create_user(@valid_attrs)
      assert "has already been taken" in errors_on(changeset).email
    end

    test "create_user/1 with duplicate username returns error changeset" do
      assert {:ok, %User{}} = Accounts.create_user(@valid_attrs)
      dup_username = Enum.into(%{email: "another@email.com"}, @valid_attrs)
      assert {:error, changeset} = Accounts.create_user(dup_username)
      assert "has already been taken" in errors_on(changeset).username
    end

    test "create_user/1 with invalid username length returns error changeset" do
      invalid_attrs = %{username: "vand"} |> Enum.into(@valid_attrs)
      assert {:error, changeset} = Accounts.create_user(invalid_attrs)
      assert "should be at least 5 character(s)" in errors_on(changeset).username
    end

    test "create_user/1 with invalid username format returns error changeset" do
      invalid_attrs = %{username: "1vand@"} |> Enum.into(@valid_attrs)
      assert {:error, changeset} = Accounts.create_user(invalid_attrs)
      assert "has invalid format" in errors_on(changeset).username
    end
  end
end
