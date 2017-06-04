class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :admin_id, :integer #admin_id
      t.column :title, :string
      t.column :content, :text
      t.column :start_time, :datetime
      t.column :send_object, :integer
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
