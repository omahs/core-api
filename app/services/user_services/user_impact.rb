module UserServices
  class UserImpact
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    def impact
      non_profits.map { |non_profit| format_result(non_profit) }
    end

    private

    def format_result(non_profit)
      { non_profit:, impact: impact_sum_by_non_profit(non_profit) }
    end

    def impact_sum_by_non_profit(non_profit)
      usd_to_impact_factor = non_profit.impact_for(date: Time.zone.now).usd_cents_to_one_impact_unit

      (total_usd_cents_donated_for(non_profit) / usd_to_impact_factor).to_i
    end

    def total_usd_cents_donated_for(non_profit)
      user.donations.where(non_profit:).sum(&:value)
    end

    def non_profits
      NonProfit.all
    end
  end
end
