class CreateSubdistricts < ActiveRecord::Migration
  def change
    create_table :subdistricts do |t|
      t.string	:name
      t.timestamps
    end
  end
end
