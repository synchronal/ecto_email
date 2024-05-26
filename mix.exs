defmodule EctoEmail.MixProject do
  use Mix.Project

  @scm_url "https://github.com/synchronal/ecto_email"

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
      description: "An Ecto.Type for email address fields",
      dialyzer: dialyzer(),
      docs: docs(),
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      homepage_url: @scm_url,
      name: "Ecto.Email",
      package: package(),
      source_url: @scm_url,
      start_permanent: Mix.env() == :prod,
      version: "1.0.0"
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
      {:email_validator, "~> 1.1"},
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
      main: "Ecto.Email",
      extras: ["LICENSE.md", "CHANGELOG.md"]
    ]

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package,
    do: [
      files: ~w(lib .formatter.exs mix.exs *.md),
      licenses: ["MIT"],
      maintainers: ["synchronal.dev", "Erik Hanson", "Eric Saxby"],
      links: %{"GitHub" => @scm_url}
    ]
end
