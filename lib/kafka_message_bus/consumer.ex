defmodule KafkaMessageBus.MessageProcessor do
  @topics_and_processors Application.get_env(:kafka_message_bus, :consumers)
  require Logger

  def handle_messages(messages) do
    for message = %{key: key, value: value} <- messages do
      Logger.debug "Got message: KEY: #{key}, VALUE: #{value}"
      process_message(message)
    end
    :ok
  end

  def process_message(message) do
    @topics_and_processors
    |> Enum.map(fn config -> execute_message(message, config) end)
  end

  def execute_message(message = %{topic: topic}, {topic, message_processor}) do
    message.value
    |> Poison.decode!
    |> message_processor.process(message.key)
    :ok
  end

  def execute_message(_, _) do
    :ok
  end
end
