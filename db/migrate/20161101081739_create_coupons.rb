class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :name, :string
      t.column :limit_from, :datetime
      t.column :limit_to, :datetime
      t.column :price, :float
      t.column :send_object, :integer
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
