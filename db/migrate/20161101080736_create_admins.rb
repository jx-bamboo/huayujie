class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :login, :string
      t.column :name, :string
      t.column :email, :string
      t.column :password, :string
      t.column :phone, :string
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
