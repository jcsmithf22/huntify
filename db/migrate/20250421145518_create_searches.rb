class CreateSearches < ActiveRecord::Migration[8.0]
  def change
    create_table :searches do |t|
      t.string :name
      t.text :notes
      t.text :keywords
      t.boolean :include_description
      t.string :category
      t.string :condition
      t.string :postal_code
      t.string :type
      t.integer :price_min_cents
      t.integer :price_max_cents
      t.integer :best_offer_max_cents

      t.timestamps
    end
  end
end
