class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :owner_id, :integer
      t.column :type, :string
      t.column :file_name, :string
      t.column :file_path, :string
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
