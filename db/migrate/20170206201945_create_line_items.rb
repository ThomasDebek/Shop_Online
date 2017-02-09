class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :product, index: true, foreign_key: true
      t.decimal :unit_price
      t.integer :quantity
      t.belongs_to :order, index: true, foreign_key: true
      t.string :item_name

      t.timestamps null: false
    end
  end
end
