class CreateDpts < ActiveRecord::Migration
  def change
    create_table :dpts do |t|
      t.references	:recapitulation
      t.string	:name
      t.string	:value
      t.timestamps
    end
  end
end
