module UserImpacts
  # TODO: change user model to use this service
  class UserImpact
    def impact
      donation_balances = Graphql::RibonApi::Client.query(Graphql::Queries::FetchDonationBalances::Query)

      user_donations = donation_balances.original_hash['data']['donationBalances'].select do |donation|
        donation['user'] == hashed_email
      end

      result = {}

      user_donations.each do |donation|
        result = {
          non_profit: [donation['nonProfit']],
          total_donated: donation['totalDonated']
        }
      end

      result
    end

    def hashed_email
      "0x#{Digest::Keccak.new(256).hexdigest(email)}"
    end
  end
end
