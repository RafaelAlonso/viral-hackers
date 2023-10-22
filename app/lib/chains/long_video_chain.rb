module Chains
  class LongVideoChain
    def self.call(platform_script)
      script = platform_script.script
      @@base_script = script.output

      @@context_prompt = "#{Prompts::MainContext.build()} #{Prompts::LongVideoDefinitionConstraints.build(@@base_script)}"

      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

      @@message_prompt = "restrições = {categoria: #{script.category}, tom_do_roteiro: #{script.mood}, audiência_alvo: #{script.target_audience}

      Conteúdo detalhado e completo com mais de 10 parágrafos:
      "

      chat = Langchain::Conversation.new(llm: llm, temperature: 0.9, model: "gpt-4")
      chat.set_context(@@context_prompt)
      chat.message(@@message_prompt)
    end
  end
end
