class CreateMenuImages < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_images do |t|

      t.timestamps
    end
  end
end
