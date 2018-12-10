class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :start
      t.datetime :end
      t.text :name
      t.text :location
      t.text :context

      t.timestamps
    end
  end
end
