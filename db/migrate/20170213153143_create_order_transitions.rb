class CreateOrderTransitions < ActiveRecord::Migration
  def change
    create_table :order_transitions do |t|
      t.string :to_state, null: false
      t.text :metadata
      t.integer :sort_key, null: false
      t.integer :order_id, null: false
      t.boolean :most_recent
      t.timestamps null: false
    end

    add_index(:order_transitions,
              [:order_id, :sort_key],
              unique: true,
              name: "index_order_transitions_parent_sort")
    add_index(:order_transitions,
              [:order_id, :most_recent],
              unique: true,
              
              name: "index_order_transitions_parent_most_recent")
  end
end
