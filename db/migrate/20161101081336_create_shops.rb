class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :name, :string
      t.column :address, :string
      t.column :phone, :string
      t.column :business_hours, :string
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
