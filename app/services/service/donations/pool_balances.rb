module Service
  module Donations
    class PoolBalances
      attr_reader :pool

      def initialize(pool:)
        @pool = pool
      end

      def add_balance_history
        balance = pool_balance
        pool.balance_histories.create!(cause:, balance:, amount_donated:) if balance.positive?
      end

      def update_balance
        balance = pool_balance - amount_free_donations_without_batch
        pool_balance = pool.pool_balance || PoolBalance.create(pool:)
        pool_balance.update!(balance:)
      end

      private

      def cause
        pool.cause
      end

      def contract_address
        pool.token.address
      end

      def address
        pool.address
      end

      def pool_balance
        Web3::Networks::Polygon::Scan.new(contract_address:, address:).balance.to_f / (10**pool.token.decimals)
      end

      def amount_free_donations
        amount_donations_sql = "SELECT SUM(value) as sum FROM donations
               left outer join non_profits on non_profits.id = donations.non_profit_id
               left outer join causes on causes.id = non_profits.cause_id
               WHERE causes.id = #{cause.id}"
        amount_donations = ActiveRecord::Base.connection.execute(amount_donations_sql).first['sum'].to_f
        amount_donations / 100
      end

      def amount_free_donations_without_batch
        amount_donations_sql = "SELECT SUM(value) as sum FROM donations
               left outer join non_profits on non_profits.id = donations.non_profit_id
               left outer join causes on causes.id = non_profits.cause_id
               left outer join donation_batches on donation_batches.donation_id = donations.id
               where causes.id = #{cause.id}
               and donation_batches.id is null"
        amount_donations = ActiveRecord::Base.connection.execute(amount_donations_sql).first['sum'].to_f
        amount_donations / 100
      end

      def amount_donated
        amount_free_donations
      end
    end
  end
end
