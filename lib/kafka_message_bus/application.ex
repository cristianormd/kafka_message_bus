defmodule KafkaMessageBus.Application do
  use Application

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
    |> Enum.map(&get_topic(&1))
    |> Enum.reduce([], fn(topic_list, acc) -> acc ++ topic_list end)
  end

  def get_topic({topic, _processor}), do: [topic]
  def get_topic(_), do: []
end
