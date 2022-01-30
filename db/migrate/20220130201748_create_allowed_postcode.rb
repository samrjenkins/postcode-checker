class CreateAllowedPostcode < ActiveRecord::Migration[7.0]
  def change
    create_table :allowed_postcodes do |t|
      t.string :postcode, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
