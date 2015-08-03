class CreateHubs < ActiveRecord::Migration
  def change
    create_table :hubs do |t|

      t.text :acc_link
      t.text :photo_url
      t.string :title
      t.text :description
      t.timestamps null: false
      
    end
  end
end
