require "langchain"

module Chains

  class MainChain
    def self.call(script)
      @@paragraphs = ((script.duration * 1.5)/50).ceil
      @@word_count = (script.duration * 1.5).ceil

      @@context_prompt = "You are a viral content maker for a social media platform. You only speak Brazillian portuguese. Your goal is to generate a script to be used by an influencer following the constraints defined in the JSON structure below. You should use at most #{@@paragraphs} paragraphs. Use #{@@word_count} words. Do not use emojis nor hashtags. The main theme of the script will be defined in brackets."

      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

      @@final_prompt = "constraints = {category: #{script.category}, duration_in_seconds: #{script.duration}, mood: #{script.mood}} [#{script.description}]"

      chat = Langchain::Conversation.new(llm: llm, temperature: 0.9, model: "gpt-4")
      chat.set_context(@@context_prompt)
      chat.message( @@final_prompt)
    end
  end
end