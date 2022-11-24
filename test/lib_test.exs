defmodule LibTest do
  use ExUnit.Case
  alias Lib.{Book, Repo}
  alias Ecto.Adapters.SQL.Sandbox

  import Ecto.Query

  setup(_context) do
    pid = Sandbox.start_owner!(Lib.Repo, shared: false)
    on_exit(fn -> Sandbox.stop_owner(pid) end)
  end

  describe "searches using json field" do
    setup :insert_book

    test "works with fragment and simple string", %{book: book} do
      result =
        Book
        |> where([b], fragment("(meta -> 'formats' -> 'digital')::boolean = false"))
        |> Repo.all()

      assert [book] == result
    end

    test "works with fragment and meta field as a variable", %{book: book} do
      result =
        Book
        |> where([b], fragment("(? -> 'formats' -> 'digital')::boolean = false", b.meta))
        |> Repo.all()

      assert [book] == result
    end

    test "does not work with fragment and field and path as variables, but it should!", %{
      book: book
    } do
      result =
        Book
        |> where([b], fragment("(? -> ?)::boolean = false", b.meta, "'formats' -> 'digital'"))
        |> Repo.all()

      assert [book] == result
    end
  end

  defp insert_book(_context) do
    book =
      Repo.insert!(%Book{
        title: "master of none",
        meta: %{"formats" => %{"digital" => false}}
      })

    %{book: book}
  end
end
