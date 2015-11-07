defmodule Mallery.Repo.Migrations.AddFieldsToImages do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add :name, :string
      add :description, :string
    end
  end
end
