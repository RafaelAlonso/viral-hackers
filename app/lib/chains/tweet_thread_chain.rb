module Chains
  class TweetThreadChain
    def self.call(script)
      @@base_script = script.output

      @@context_prompt = "#{Prompts::MainContext.build()} #{Prompts::TweetThreadDefinitionConstraints.build(@@base_script)}"

      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

      @@message_prompt = "restrições = {categoria: #{script.category}, tom_da_thread_de_tweets: #{script.mood}, audiência_alvo: #{script.target_audience}
      
      Thread de tweets com cada tweet separado por 3 cerquilhas:
      "

      chat = Langchain::Conversation.new(llm: llm, temperature: 0.9, model: "gpt-4")
      chat.set_context(@@context_prompt)
      chat.message(@@message_prompt)
    end
  end
end
