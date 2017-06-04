class CreateInquiries < ActiveRecord::Migration[5.0]
  def change
    create_table :inquiries, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :name, :string
      t.column :email, :string
      t.column :phone, :string
      t.column :sex, :string
      t.column :title, :string
      t.column :content, :text
      t.column :inquiry_date, :datetime
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
