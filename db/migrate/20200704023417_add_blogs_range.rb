class AddBlogsRange < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :range, :integer
  end
end
