class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create
    template "service_template.template", Rails.root.join("app/services/#{formatted_file_name}.rb")
    template "service_spec_template.template", Rails.root.join("spec/services/#{formatted_file_name}_spec.rb")
  end

  private

  def formatted_file_name
    (class_name + 'Service').underscore
  end
end
