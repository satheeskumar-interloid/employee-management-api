class AddDetailsToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :description, :text
    add_column :projects, :status, :string
    add_column :projects, :start_date, :date
    add_column :projects, :end_date, :date
    add_column :projects, :owner_id, :integer
  end
end
