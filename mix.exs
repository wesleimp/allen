defmodule Allen.MixProject do
  use Mix.Project

  def project do
    [
      app: :allen,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:syntax_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
  end

  defp package do
    [
      name: :allen,
      description: "A read-only module constant pool",
      maintainers: ["Weslei Juan Novaes Pereira"],
      licenses: ["MIT"],
      files: ["lib/*", "mix.exs", "README*", "LICENSE*"],
      links: %{
        "GitHub" => "https://github.com/wesleimp/allen"
      }
    ]
  end
end
