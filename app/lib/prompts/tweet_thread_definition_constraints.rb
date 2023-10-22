class Prompts::TweetThreadDefinitionConstraints < Prompts::Base
  def self.build(base_script)
    @@prompt = "Você irá escrever uma thread de tweets com 150 caracteres cada baseado em um script pré definido. Use emojis e hashtags. O conteúdo deve ser dividido da seguinte forma: um gancho persuasivo e chamativo que prenda a atenção do usuário; o conteúdo, que pode ser entregue em formato de lista; e por fim uma chamada para seguir o perfil. Separe o conteúdo da melhor forma entre os tweets O tema principal do tweet será definido entre colchetes. Delimitado por chaves está o script pré definido que deve ser utilizado como base: {#{base_script}}"
  end
end
