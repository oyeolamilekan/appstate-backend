# == Schema Information
#
# Table name: integrations
#
#  id              :bigint           not null, primary key
#  endpoint_secret :string
#  key             :string
#  provider        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  public_id       :string
#  store_id        :bigint           not null
#
# Indexes
#
#  index_integrations_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
require "test_helper"

class IntegrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
