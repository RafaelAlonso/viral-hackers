class Prompts::ShortVideoDefinitionConstraints < Prompts::Base
  def self.build(paragraphs, word_count, script_examples)
    @@prompt = "Você deve usar no máximo #{paragraphs} parágrafos. Use no máximo #{word_count} palavras. Não use emojis nem hashtags. O conteúdo deve ser dividido da seguinte forma: um gancho persuasivo e chamativo que prenda a atenção do usuário; o conteúdo, que pode ser entregue em formato de lista; e por fim uma chamada para seguir o perfil. O tema principal do roteiro será definido entre colchetes. Delimitado por chaves estão exemplos de roteiros que você deve usar como base, cada exemplo está separado por 3 cerquilhas: {#{script_examples}}"
  end
end