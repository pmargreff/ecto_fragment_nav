import Config

config :lib,
  ecto_repos: [Lib.Repo]

config :lib, Lib.Repo,
  database: "lib_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
