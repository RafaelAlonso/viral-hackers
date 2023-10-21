return unless Rails.env.development?

puts "Limpando categorias e contextos"
Category.destroy_all # destrói contextos também (dependent: :destroy)
puts "=" * 10

puts "Criando categorias"
categories = ['Saúde', 'Desenvolvimento Pessoal', 'Marketing', 'Viagens', 'Tech', 'Empreendedorismo']
categories.each do |category_name|
  category = Category.create(name: category_name)
  puts "Categoria '#{category_name}' criada."

  file_path = Rails.root.join('tmp', 'contexts', "#{category_name.downcase}.json")
  if File.exists? file_path
    puts "Criando contextos"
    context_file = File.read(file_path)
    contexts = JSON.parse(context_file)
    contexts.each do |context|
      Context.create(category: category, description: context)
    end
    puts "#{contexts.count} contextos criados para #{category_name}."
  end
  puts "=" * 10
end
