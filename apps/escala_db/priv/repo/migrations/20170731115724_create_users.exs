defmodule EscalaDb.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\" with schema public"
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :text, null: false
      add :username, :text
      add :first_name, :text
      add :last_name, :text
      add :picture, :text
      add :providers, {:array, :text}, null: false
      add :meta, :map

      timestamps()
    end
    create unique_index(:users, :email)
    create unique_index(:users, :username)
  end

  def down do
    drop table(:users)
  end
end
