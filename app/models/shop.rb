class Shop < ApplicationRecord
  validates :name, :address, :phone, :business_hours, presence: true
  validates :name, uniqueness: true
  validates :phone,length: {minimum: 8}

  has_one :shop_image,:foreign_key => :owner_id, dependent: :destroy
  has_many :menus,:through => :shop_menus
  has_many :shop_menus
  has_many :coupons, :through => :shop_coupons
  has_many :shop_coupons
  has_many :buy_records

  def get_attachment
    shop_image =ShopImage.find_by("owner_id = ?","#{self.id}")
    return "" if shop_image.blank?
    return "#{shop_image.file_path}original_image/#{shop_image.file_name}"
  end




end
