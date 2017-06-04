class CreateMessageUpdateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :message_update_records, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :user_id, :integer
      t.column :update_date, :datetime
      t.column :update_type, :string
      t.column :memo, :text
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
