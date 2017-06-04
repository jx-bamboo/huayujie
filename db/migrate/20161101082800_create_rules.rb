class CreateRules < ActiveRecord::Migration[5.0]
  def change
    create_table :rules, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :content, :text
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
