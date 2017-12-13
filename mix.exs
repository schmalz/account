defmodule Account.Mixfile do
  use Mix.Project

  def project do
    [
      app: :account,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Account.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:comeonin, "~> 4.0"},
      {:argon2_elixir, "~> 1.2"},
      {:uuid, "~> 1.1"},
      {:amnesia, git: "https://github.com/meh/amnesia"},
      {:logger_file_backend, git: "https://github.com/onkel-dirtus/logger_file_backend"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:distillery, "~> 1.5", runtime: false}
    ]
  end
end
