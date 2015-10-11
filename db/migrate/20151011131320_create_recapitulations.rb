class CreateRecapitulations < ActiveRecord::Migration
  def change
    create_table :recapitulations do |t|
      t.references	:category
      t.references 	:subdistrict
      t.string	:using_suffrage
      t.string	:voter_presentation
      t.timestamps
    end
  end
end
