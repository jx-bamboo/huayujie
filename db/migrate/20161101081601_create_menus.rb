class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :category_id, :integer
      t.column :name, :string
      t.column :genre, :string
      t.column :price, :float
      t.column :calorie, :float
      t.column :salt, :float
      t.column :memo, :text
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
