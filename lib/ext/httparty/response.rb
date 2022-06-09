HTTParty::Response.class_eval do
  def nil?
    response.nil? || response.body.nil? || response.body.empty?
  end
end
