defmodule Lib.Repo do
  use Ecto.Repo,
    otp_app: :lib,
    adapter: Ecto.Adapters.Postgres
end
