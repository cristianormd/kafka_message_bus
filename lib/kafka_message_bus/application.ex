defmodule KafkaMessageBus.Application do
  use Application


  alias KafkaMessageBus.Config

  def start(_type, _args) do
    import Supervisor.Spec

    consumer =  :kaffe
              |> Application.get_env(:consumer)
              |> Keyword.put(:topics, topic_list())
    Application.put_env(:kaffe, :consumer, consumer)

    [supervisor(Kaffe.GroupMemberSupervisor, [])]
    |> Supervisor.start_link(
      strategy: :one_for_one,
      name: KafkaMessageBus.Supervisor
    )
  end

  def topic_list do
    Application.get_env(:kafka_message_bus, :consumers)
    |> Enum.map(fn({topic, processor}) -> topic end)
    |> Enum.reduce([], fn(topic, acc) -> acc ++ [topic] end)
  end
end
