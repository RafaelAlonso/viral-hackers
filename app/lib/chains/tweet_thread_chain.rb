module Chains
  class SingleTweetChain
    def self.call(script)
      @@base_script = script.output

      @@context_prompt = "#{Prompts::MainContext.build()} #{Prompts::SingleTweetDefinitionConstraints.build()}"

      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

      @@message_prompt = "restrições = {categoria: #{script.category}, tom_do_tweet: #{script.mood}, audiência_alvo: #{script.target_audience}
      
      Tweet gerado:
      "

      chat = Langchain::Conversation.new(llm: llm, temperature: 0.9, model: "gpt-4")
      chat.set_context(@@context_prompt)
      chat.message(@@message_prompt)
    end
  end
end
