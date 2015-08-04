class AddUsersToHubs < ActiveRecord::Migration
  def change
    add_column :hubs, :user_id, :integer
  end
end
