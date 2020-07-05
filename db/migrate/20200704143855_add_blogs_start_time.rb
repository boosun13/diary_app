class AddBlogsStartTime < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :start_time, :datetime
  end
end
