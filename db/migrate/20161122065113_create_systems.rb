class CreateSystems < ActiveRecord::Migration[5.0]
  def change
    create_table :systems do |t|
      t.integer :user_id
      t.integer :admin_id
      t.integer :recharge_record_id
      t.integer :buy_record_id
      t.timestamps
    end
  end
end
