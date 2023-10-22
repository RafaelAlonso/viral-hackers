module Chains
  class MainChain
    def self.call(script)
      @@paragraphs = ((script.duration * 1.5)/50).ceil
      @@word_count = (script.duration * 1.5).ceil
      @@script_examples = Context.where(category: script.category).pluck(:description).join(" ### ")

      @@context_prompt = "#{Prompts::MainContext.build()} #{Prompts::ShortVideoDefinitionConstraints.build(@@paragraphs, @@word_count, @@script_examples)}"

      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

      @@final_prompt = "restrições = {categoria: #{script.category}, duração_em_segundos: #{script.duration}, tom_do_roteiro: #{script.mood}, audiência_alvo: #{script.target_audience} [#{script.description}]"

      chat = Langchain::Conversation.new(llm: llm, temperature: 0.9, model: "gpt-4")
      chat.set_context(@@context_prompt)
      chat.message(@@final_prompt)
    end
  end
end
