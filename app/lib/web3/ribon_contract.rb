module Web3
  class RibonContract
    def self.donate_through_integration(non_profit_address:, user_email:, amount:)
      HTTParty.post('https://tsmzfesl49.execute-api.us-east-1.amazonaws.com/dev',
                    { body:
                      { nonProfit: non_profit_address,
                        user: user_email,
                        amount: amount.to_i.to_s }.to_json })
    end
  end
end
