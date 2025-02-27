# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  description     :text
#  gallery_imaages :text             default([]), is an Array
#  image_url       :string
#  name            :string
#  price           :decimal(, )
#  repo_link       :string
#  slug            :string
#  url             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  public_id       :string
#  store_id        :bigint           not null
#
# Indexes
#
#  index_products_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
