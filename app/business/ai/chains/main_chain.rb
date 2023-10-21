require "langchain"

module Business::Ai::Chains

  class MainChain
      def call(text)
        openai = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])
        openai.complete(prompt: text)
      end
  end
end