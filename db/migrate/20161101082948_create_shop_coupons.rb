class CreateShopCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :shop_coupons, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :shop_id, :integer
      t.column :coupon_id, :integer
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
