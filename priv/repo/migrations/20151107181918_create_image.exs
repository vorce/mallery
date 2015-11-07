defmodule Mallery.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :sender, :string
      add :img_url, :string
      add :url_prefix, :string

      timestamps
    end

  end
end
