class ApplicationCommand
  protected

  def with_exception_handle
    yield
  rescue StandardError => e
    Reporter.log(error: e)
    errors.add(:message, e.message)
  end
end
