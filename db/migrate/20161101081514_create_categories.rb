class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :name, :string
      t.column :memo, :string
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
