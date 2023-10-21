module Chains
  class MainChain
    def self.call(script)
      @@paragraphs = ((script.duration * 1.5)/50).ceil
      @@word_count = (script.duration * 1.5).ceil
      @@script_examples = Context.where(category: script.category).pluck(:description).join(" ### ")

      @@context_prompt = "Você é um criador de conteúdo viral para uma plataforma de mídia social. Você fala apenas português brasileiro. Seu objetivo é gerar um roteiro a ser usado por um influenciador, seguindo as restrições definidas na estrutura JSON abaixo. Você deve usar no máximo #{@@paragraphs} parágrafos. Use no máximo #{@@word_count} palavras. Não use emojis nem hashtags. O tema principal do roteiro será definido entre colchetes. Delimitado por chaves estão exemplos de roteiros que você deve usar como base, cada exemplo está separado por 3 cerquilhas: {#{@@script_examples}}"

      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

      @@final_prompt = "restrições = {categoria: #{script.category}, duração_em_segundos: #{script.duration}, entonação: #{script.mood}, audiência_alvo: #{script.context} [#{script.description}]"

      chat = Langchain::Conversation.new(llm: llm, temperature: 0.9, model: "gpt-4")
      chat.set_context(@@context_prompt)
      chat.message(@@final_prompt)
    end
  end
end
