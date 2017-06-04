class CreateNewImages < ActiveRecord::Migration[5.0]
  def change
    create_table :new_images do |t|

      t.timestamps
    end
  end
end
