class CreateBuyRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :buy_records, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :user_id, :integer
      t.column :shop_id, :integer
      t.column :menu_id, :integer
      t.column :price, :float
      t.column :buy_date, :datetime
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
