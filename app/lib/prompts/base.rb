class Prompts::Base
    def self.build()
        raise NotImplementedError
    end
end