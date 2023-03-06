# frozen_string_literal: true

class UserQueries
  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def last_contribution
    sql = %(
    SELECT "public"."person_payments"."id" AS "id", "public"."person_payments"."paid_date" AS "paid_date", "public"."person_payments"."payment_method" AS "payment_method", "public"."person_payments"."status" AS "status", "public"."person_payments"."created_at" AS "created_at", "public"."person_payments"."updated_at" AS "updated_at", "public"."person_payments"."offer_id" AS "offer_id", "public"."person_payments"."amount_cents" AS "amount_cents", "public"."person_payments"."person_id" AS "person_id", "public"."person_payments"."integration_id" AS "integration_id", "public"."person_payments"."external_id" AS "external_id", "public"."person_payments"."refund_date" AS "refund_date", "public"."person_payments"."receiver_type" AS "receiver_type", "public"."person_payments"."receiver_id" AS "receiver_id", "public"."person_payments"."error_code" AS "error_code", "public"."person_payments"."currency" AS "currency"
    FROM "public"."person_payments" LEFT JOIN "public"."people" "People" ON "public"."person_payments"."person_id" = "People"."id"
    LEFT JOIN "public"."customers" "Customers" ON "People"."id" = "Customers"."person_id"
    LEFT JOIN "public"."users" "Users" ON "Customers"."user_id" = "Users"."id"
    WHERE "Users"."id" = #{user.id}
    ORDER BY "public"."person_payments"."paid_date" DESC
    LIMIT 1)

    PersonPayment.find_by_sql(sql).last
  end

  def self.users_that_last_contributed_in(date)
    sql = %(
    SELECT DISTINCT "Users"."id" AS "id", "Users"."email" AS "email", "Users"."created_at" AS "created_at", "Users"."updated_at" AS "updated_at", "Users"."language" AS "language"
    FROM "public"."person_payments" LEFT JOIN "public"."people" "People"
    ON "public"."person_payments"."person_id" = "People"."id"
    LEFT JOIN "public"."customers" "Customers" ON "People"."id" = "Customers"."person_id"
    LEFT JOIN "public"."users" "Users" ON "Customers"."user_id" = "Users"."id"
    WHERE "public"."person_payments"."paid_date"::date = '#{date.to_date}'::date
    )

    User.find_by_sql(sql)
  end
end
