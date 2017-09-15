defmodule KafkaMessageBus.Application do
  use Application
<<<<<<< HEAD


  alias KafkaMessageBus.Config

  def start(_type, _args) do
    import Supervisor.Spec

    consumer =  :kaffe
              |> Application.get_env(:consumer)
              |> Keyword.put(:topics, topic_list())
    Application.put_env(:kaffe, :consumer, consumer)

=======
  def start(_type, _args) do
    import Supervisor.Spec

>>>>>>> 65603d3e3f052ab7926f4c92c7381e20f358437b
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
