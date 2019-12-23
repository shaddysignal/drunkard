defmodule Drunkard.MixProject do
  use Mix.Project

  def project do
    [
      app: :drunkard,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Drunkard.Application, []},
      extra_applications: [:logger, :runtime_tools, :lbm_kv]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.6"},                       # Core
      {:phoenix_pubsub, "~> 1.1"},                  # ?
      {:phoenix_ecto, "~> 4.0"},                    # Ecto integration
      {:ecto_sql, "~> 3.0"},                        # Ecto integration
      {:postgrex, ">= 0.0.0"},                      # Postgres elixir integration
      {:phoenix_html, "~> 2.11"},                   # Some html and template bussines?
      {:phoenix_live_reload, "~> 1.2", only: :dev}, # Some html and template bussines?
      {:gettext, "~> 0.11"},                        # internalisation
      {:jason, "~> 1.0"},                           # Json de/serilalizer?
      {:plug_cowboy, "~> 2.0"},                     # Core server
      {:protobuf, "~> 0.6.3"},                      # Protobuf integration
      {:guardian, "~> 1.2"},                        # JWT or whatever auth
      {:argon2_elixir, "~> 2.0"},                   # Password hashing
      {:lbm_kv, "~> 0.0.2"},                        # Distributed key-val database
      {:pow, "~> 1.0.13"},
      {:phoenix_live_view, "~> 0.4.0"},
      {:floki, ">= 0.0.0", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.softreset": ["ecto.rollback", "ecto.migrate"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
