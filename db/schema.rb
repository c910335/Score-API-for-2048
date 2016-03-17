ActiveRecord::Schema.define(version: 20160317002247) do
   create_table :players do |t|
      t.string :name, null: false
      t.string :token, null: false, index: true
      t.integer :score, null: false
   end
end
