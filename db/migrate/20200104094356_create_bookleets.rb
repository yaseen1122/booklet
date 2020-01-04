class CreateBookleets < ActiveRecord::Migration[5.2]
  def change
    create_table :bookleets do |t|
      t.string :name

      t.timestamps
    end
  end
end
