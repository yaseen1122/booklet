class AddBookleetToTbcs < ActiveRecord::Migration[5.2]
  def change
    add_reference :tbcs, :bookleet, foreign_key: true
  end
end
