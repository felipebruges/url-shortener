class CreateShortUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :short_urls do |t|
      t.references :user
      t.string :original
      t.string :short
      t.string :slug

      t.timestamps
    end

    add_index :short_urls, :original, unique: true
    add_index :short_urls, :slug, unique: true
  end
end
