class CreditCard
  attr_reader :cvv, :number, :name, :expiration_month, :expiration_year

  def initialize(cvv:, number:, name:, expiration_month:, expiration_year:)
    @cvv = cvv
    @number = number
    @name = name
    @expiration_month = expiration_month
    @expiration_year = expiration_year
  end
end