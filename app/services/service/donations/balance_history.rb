module Service
  module Donations
    class BalanceHistory
      attr_reader :pool

      def initialize(pool:)
        @pool = pool
      end

      def add_balance
        @pool.balance_histories.create!(date:, cause:, balance:, amount_donated:) if balance > 0
      end

      private

      def date
        Time.zone.today
      end

      def cause
        @pool.cause
      end

      def balance
        result = Graphql::RibonApi::Client.query(Graphql::Queries::FetchPools::Query)
        result.data.pools.find{|x| x.id == pool.address}&.balance.to_i
      end
      
      def amount_free_donations
        amount_today_donations = "SELECT SUM(value) FROM donations 
               left outer join non_profits on non_profits.id = donations.non_profit_id
               left outer join causes on causes.id = non_profits.cause_id
               WHERE donations.created_at BETWEEN '#{start_date}' AND '#{end_date}' 
               AND causes.id = #{cause.id}"
        ActiveRecord::Base.connection.execute(amount_today_donations).first['sum'].to_f
      end

      def amount_paid_donations
        PersonPayment.where(status: :paid,created_at: start_date..end_date).map{ |person_payment|
          person_payment.pool.id == @pool.id ? person_payment.crypto_amount : 0
        }.sum
      end

      def amount_donated
        amount_free_donations + amount_paid_donations
      end

      def start_date
        Time.zone.yesterday.beginning_of_day
      end

      def end_date
        Time.zone.yesterday.end_of_day
      end
    end
  end
end
