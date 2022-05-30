# frozen_string_literal: true

module StubHelpers
  def command_double(klass:, result: nil, errors: {}, failure: false, success: true)
    instance_double(klass.to_s, result: result,
                                errors: errors, failure?: failure, success?: success)
  end

  def mock_instance(klass:, methods: {}, mock_methods: [])
    mocked_instance = instance_double(klass, methods)
    allow(klass).to receive(:new).and_return(mocked_instance)

    mock_methods.each { |method_name| allow(mocked_instance).to receive(method_name) }
    mocked_instance
  end
end
