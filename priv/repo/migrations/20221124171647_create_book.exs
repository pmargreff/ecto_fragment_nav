defmodule Lib.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :meta, :map, null: false
    end
  end
end
