# frozen_string_literal: true

module StubHelpers
  def command_double(klass:, result: nil, errors: {}, failure: false, success: true)
    instance_double(klass.to_s, result: result,
                                errors: errors, failure?: failure, success?: success)
  end
end
