require "langchain"

module Chains

  class MainChain
    def self.call(text)
      openai = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])
      openai.complete(prompt: text)
    end
  end
end