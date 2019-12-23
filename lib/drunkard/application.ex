defmodule Drunkard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Drunkard.Accounts.TokenAuthority.init("secret_salt")

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Drunkard.Repo,
      # Start the endpoint when the application starts
      DrunkardWeb.Endpoint,
      # Starts a worker by calling: Drunkard.Worker.start_link(arg)
      # {Drunkard.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Drunkard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DrunkardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
