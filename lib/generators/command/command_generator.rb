class CommandGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create
    template "command_template.template", Rails.root.join("app/commands/#{class_name.underscore}.rb")
    template "command_spec_template.template", Rails.root.join("spec/commands/#{class_name.underscore}_spec.rb")
  end
end
