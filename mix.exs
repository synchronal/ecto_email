defmodule EctoEmail.MixProject do
  use Mix.Project

  def application,
    do: [
      extra_applications: [:logger]
    ]

  def cli,
    do: [
      preferred_envs: [
        credo: :test,
        dialyzer: :test
      ]
    ]

  def project,
    do: [
      app: :ecto_email,
      deps: deps(),
      dialyzer: dialyzer(),
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      version: "0.1.0"
    ]

  # # #

  defp deps,
    do: [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ecto_temp, "~> 1.1", only: :test},
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false}
    ]

  def dialyzer,
    do: [
      plt_add_apps: [:ex_unit, :mix],
      plt_add_deps: :app_tree,
      plt_core_path: "_build/plts/#{Mix.env()}",
      plt_local_path: "_build/plts/#{Mix.env()}"
    ]
end
