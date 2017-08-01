defmodule EscalaDb.DbCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias EscalaDb.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import EscalaDb.DbCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EscalaDb.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(EscalaDb.Repo, {:shared, self()})
    end

    :ok
  end

  @doc """
  A Helper that transform changeset errors to a map of messages

      assert {:error, changeset} = Accounts.create_user(%{email: "invalid"})
      assert "has invalid format" in errors_on(changeset).email
      assert %{email: ["has invalid format"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
