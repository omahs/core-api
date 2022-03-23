module UserServices
  module UserImpact
    def impact
      donation_balances = Graphql::RibonApi::Client.query(Graphql::Queries::FetchDonationBalances::Query)
      user_donations = select_from_donation_balances(donation_balances)

      format_user_donations(user_donations)
    end

    private

    def select_from_donation_balances(donation_balances)
      donation_balances.original_hash['data']['donationBalances'].select do |donation|
        donation['user'] == hashed_email
      end
    end

    def format_user_donations(user_donations)
      user_donations.map do |donation|
        {
          non_profit: non_profit_from_address(donation['nonProfit']),
          total_donated: donation['totalDonated']
        }
      end
    end

    def non_profit_from_address(wallet_address)
      NonProfit.find_by('lower(wallet_address) = ?', wallet_address.downcase)
    end

    def hashed_email
      "0x#{Digest::Keccak.new(256).hexdigest(email)}"
    end
  end
end
