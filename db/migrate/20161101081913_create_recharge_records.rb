class CreateRechargeRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :recharge_records, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :user_id, :integer
      t.column :recharge_point, :integer
      t.column :total_point, :integer
      t.column :recharge_date, :datetime
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
