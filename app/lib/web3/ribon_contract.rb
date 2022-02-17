module Web3
  class RibonContract
    def self.donate_through_integration(non_profit:, user:, amount:)
      results = HTTParty.post('https://tsmzfesl49.execute-api.us-east-1.amazonaws.com/dev',
                               { body:
                                 { nonProfit: non_profit,
                                   user: user,
                                   amount: amount }.to_json })
    end
  end
end