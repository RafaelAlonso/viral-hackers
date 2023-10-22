class Prompts::LongVideoDefinitionConstraints < Prompts::Base
  def self.build(base_script, nickname, call_to_action)
    @@prompt = "O conteúdo deve ser dividido seguindo o padrão:
    Introdução: Uma introdução chamativa e que estimule o usuário a ficar até o final do vídeo. Exemplo: `Você vai descobrir os 5 melhores alimentos para aumentar sua massa muscular. O último é o mais poderoso, por isso, assista até o final.`

    Apresentação_e_call_to_action_para_like: Utilize o pseudônimo #{nickname} para o conteúdo Exemplo: `Eu sou o [PSEUDÔNIMO], e se esse tema é interessante para você, já se inscreve no canal e aperta no like agora mesmo.`

    Conteúdo: Aqui é onde o conteúdo prometido vai ser entregue para o usuário de forma clara. Utilize entre 800 a 1000 palavras, e 8 a 10 paragrafos.

    call_to_action_final: Aqui o usuário faz uma call uma call to action para onde preferir. #{call_to_action.nil? ? "Exemplo: `Se esse conteúdo fez sentido para você, clique no primeiro link da descrição e faça o download gratuito do meu ebook sobre ganho de massa muscular.`": "Utilize o seguinte call to action: #{call_to_action}"}

    Delimitado por chaves está o script que deve ser utilizado como base: {#{base_script}}
    
    Seja bem detalhado e utilize mais de 1000 palavras para gerar o conteúdo."
  end
end