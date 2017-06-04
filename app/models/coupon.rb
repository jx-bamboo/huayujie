class Coupon < ApplicationRecord
  validates :name,:limit_from,:limit_to,:price,:send_object,presence: true
  validates :name,uniqueness: true
  validates_presence_of :coupon_image, message: "不能為空字符"
  validates_presence_of :shop_coupons, message: "不能為空字符"
  validates :coupon_image, presence: true

  has_one :coupon_image, :foreign_key => :owner_id, dependent: :destroy
  has_many :shops, :through => :shop_coupons
  has_many :shop_coupons, dependent: :destroy

  def get_shop_name
    self.shops.collect{|shop| shop.name}
  end

  def get_shop_id
    self.shops.collect { |shop| shop.id }
  end

  def get_attachment
    coupon_image = CouponImage.find_by("owner_id = ?","#{self.id}")
    return "" if coupon_image.blank?
    return "#{coupon_image.file_path}original_image/#{coupon_image.file_name}"
  end

end
