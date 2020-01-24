class AddSelectedFilesToBookleet < ActiveRecord::Migration[5.2]
  def change
    add_column :bookleets, :selected_files, :jsonb, using: 'CAST(value AS JSON)'
  end
end
