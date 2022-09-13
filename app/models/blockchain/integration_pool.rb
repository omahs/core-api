# == Schema Information
#
# Table name: integration_pools
#
#  id             :bigint           not null, primary key
#  integration_id :bigint           not null
#  pool_id        :bigint           not null
#
class IntegrationPool < ApplicationRecord
  belongs_to :integration
  belongs_to :pool
end
