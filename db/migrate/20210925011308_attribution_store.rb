class AttributionStore < ActiveRecord::Migration[5.2]
  def change
    create_table :attribution_stores do |t|
      t.string :session_id
      t.text :attribution_json

      t.timestamps
    end
  end
end
