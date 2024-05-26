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
      aliases: aliases(),
      app: :ecto_email,
      deps: deps(),
      dialyzer: dialyzer(),
      docs: docs(),
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      homepage_url: "https://github.com/synchronal/ecto_email",
      source_url: "https://github.com/synchronal/ecto_email",
      start_permanent: Mix.env() == :prod,
      version: "0.1.0"
    ]

  # # #

  defp aliases,
    do: [
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]

  defp deps,
    do: [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.10"},
      {:ecto_temp, "~> 1.1", only: :test},
      {:ex_doc, "~> 0.33.0", only: :dev, runtime: false},
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false},
      {:postgrex, ">= 0.0.0"}
    ]

  defp dialyzer,
    do: [
      plt_add_apps: [:ex_unit, :mix],
      plt_add_deps: :app_tree,
      plt_core_path: "_build/plts/#{Mix.env()}",
      plt_local_path: "_build/plts/#{Mix.env()}"
    ]

  defp docs,
    do: [
      main: "readme",
      extras: ["README.md", "LICENSE.md"]
    ]

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
