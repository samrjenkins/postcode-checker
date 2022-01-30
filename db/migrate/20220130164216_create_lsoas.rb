# frozen_string_literal: true

class CreateLsoas < ActiveRecord::Migration[7.0]
  def change
    create_table :lsoas do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
