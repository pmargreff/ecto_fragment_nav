defmodule Lib.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field(:title, :string)
    field(:meta, :map)
  end

  def changeset(book, attrs) do
    cast(book, attrs, [:title, :meta])
  end
end
