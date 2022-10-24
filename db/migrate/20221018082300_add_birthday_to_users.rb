class AddBirthdayToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :birthday, :datetime
  end
end
