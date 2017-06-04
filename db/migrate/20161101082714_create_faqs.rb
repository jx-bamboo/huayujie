class CreateFaqs < ActiveRecord::Migration[5.0]
  def change
    create_table :faqs, option:  'CHARSET=utf8,ENGINE=Innodb' do |t|
      t.column :ask, :string
      t.column :answer, :text
      t.column :deleted_at, :datetime
      t.timestamps
    end
  end
end
