class CreateShopMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :shop_menus, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :shop_id, :integer
      t.column :menu_id, :integer
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
