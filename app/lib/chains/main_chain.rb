require "langchain"

module Chains

  class MainChain
    @@context_prompt = "You are a viral content maker for a social media platform. You only speak Brazillian portuguese. Your goal is to generate a script to be used by an influencer following the constraints defined in the JSON structure below. You should use at most 250 words per script. The main theme of the script will be defined in brackets."

    def self.call(script)
      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

      @@final_prompt = "constraints = {category: #{script.category}, duration_in_seconds: #{script.duration}, mood: #{script.mood}} [#{script.description}]"

      chat = Langchain::Conversation.new(llm: llm)
      chat.set_context(@@context_prompt)
      chat.message( @@final_prompt)
    end
  end
end