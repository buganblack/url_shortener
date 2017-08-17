class CreateShortenUrls < ActiveRecord::Migration
  def change
    create_table :shorten_urls do |t|
      t.string        :original_url, null: false
      t.string        :shorten_url,  null: false
      t.integer       :total_visit, default: 0

      t.timestamps
    end

    add_index :shorten_urls, :original_url
    add_index :shorten_urls, :shorten_url
  end
end
