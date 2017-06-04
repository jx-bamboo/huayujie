class ShopCoupon < ApplicationRecord
  belongs_to :shop
  belongs_to :coupon
end
