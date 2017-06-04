class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :title, :string
      t.column :content, :text
      t.column :url, :string
      t.column :new_date, :datetime
      t.column :show_time_from, :datetime
      t.column :show_time_to, :datetime
      t.column :show_flag, :boolean
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
