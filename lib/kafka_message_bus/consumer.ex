defmodule KafkaMessageBus.MessageProcessor do
  def handle_messages(messages) do
    for message = {key: key, value: value} <- messages do
      message_processor = Config.get_message_processor(message.topic)
      Logger.debug "Got message: KEY: #{key}, VALUE: #{value}"

      value
      |> Poison.decode!
      |> message_processor.process(key)
    end
    :ok
  end
end
