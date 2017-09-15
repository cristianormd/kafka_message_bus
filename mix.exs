defmodule KafkaMessageBus.Mixfile do
  use Mix.Project

  def project, do: [
    app: :kafka_message_bus,
    version: "0.3.0",
    elixir: "~> 1.4",
    build_embedded: Mix.env == :prod,
    start_permanent: Mix.env == :prod,
    deps: deps(),
    description: description(),
    package: package(),
    name: "KafkaMessageBus",
    source_url: "https://github.com/jeffhsta/kafka_message_bus"
  ]

  defp description do
    """
    Wrapper for Kaffe for internal use
    """
  end

  defp package do
    [ maintainers: ["Alan Ficagna", "Jefferson Stachelski"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/jeffhsta/kafka_message_bus"}
    ]
  end

  def application do
    [applications: [:logger, :kaffe],
     mod: {KafkaMessageBus.Application, []}
    ]
  end

  defp deps, do: [
    {:kaffe, "~> 1.0"},
    {:poison, "~> 2.0"},
    {:ex_doc, ">= 0.0.0", only: :dev},
    {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
  ]
end
