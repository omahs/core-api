class ErrorBlueprint < Blueprinter::Base
  fields :message

  field :formatted_message do |object|
    if object[:message].is_a? Array
      object[:message].join('. ')
    else
      object[:message]
    end
  end
end
