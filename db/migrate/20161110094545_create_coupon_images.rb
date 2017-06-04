class CreateCouponImages < ActiveRecord::Migration[5.0]
  def change
    create_table :coupon_images do |t|

      t.timestamps
    end
  end
end
