# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  language   :integer          default("en")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: true }, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum language: {
    en: 0,
    'pt-BR': 1
  }

  before_validation { email.downcase! }
  after_create :set_user_donation_stats

  has_many :donations
  has_many :customers

  has_one :user_donation_stats
  has_one :utm, as: :trackable

  delegate :last_donation_at, to: :user_donation_stats
  delegate :can_donate?, to: :user_donation_stats
  delegate :last_donated_cause, to: :user_donation_stats

  scope :created_between, lambda { |start_date, end_date|
                            where('created_at >= ? AND created_at <= ?', start_date, end_date)
                          }

  def impact
    UserServices::UserImpact.new(user: self).impact
  end

  def last_contribution
    sql = %Q(
    SELECT "public"."person_payments"."id" AS "id", "public"."person_payments"."paid_date" AS "paid_date",
    "public"."person_payments"."payment_method" AS "payment_method", "public"."person_payments"."status" AS "status",
    "public"."person_payments"."created_at" AS "created_at", "public"."person_payments"."updated_at" AS "updated_at",
    "public"."person_payments"."offer_id" AS "offer_id", "public"."person_payments"."amount_cents" AS "amount_cents",
    "public"."person_payments"."person_id" AS "person_id", "public"."person_payments"."integration_id" AS
    "integration_id", "public"."person_payments"."external_id" AS "external_id",
    "public"."person_payments"."refund_date" AS "refund_date", "public"."person_payments"."receiver_type"
    AS "receiver_type", "public"."person_payments"."receiver_id" AS "receiver_id",
    "public"."person_payments"."error_code" AS "error_code", "public"."person_payments"."currency" AS "currency"
    FROM "public"."person_payments" LEFT JOIN "public"."people" "People"
    ON "public"."person_payments"."person_id" = "People"."id"
    LEFT JOIN "public"."customers" "Customers" ON "People"."id" = "Customers"."person_id"
    LEFT JOIN "public"."users" "Users" ON "Customers"."user_id" = "Users"."id"
    WHERE "Users"."id" = #{self.id}
    ORDER BY "public"."person_payments"."paid_date" DESC
    LIMIT 1)
    PersonPayment.find_by_sql(sql).last
  end

  def last_contribution_at
    last_contribution&.paid_date
  end

  def self.users_that_last_contributed_in(date)
    sql = %Q(
    SELECT DISTINCT "Users"."id" AS "id", "Users"."email" AS "email", "Users"."created_at" AS "created_at",
    "Users"."updated_at" AS "updated_at", "Users"."language" AS "language"
    FROM "public"."person_payments" LEFT JOIN "public"."people" "People"
    ON "public"."person_payments"."person_id" = "People"."id"
    LEFT JOIN "public"."customers" "Customers" ON "People"."id" = "Customers"."person_id"
    LEFT JOIN "public"."users" "Users" ON "Customers"."user_id" = "Users"."id"
    WHERE "public"."person_payments"."paid_date"::date = '#{date.to_date.to_s}'::date
    )
    User.find_by_sql(sql)
  end

  private

  def set_user_donation_stats
    create_user_donation_stats unless user_donation_stats
  end
end
