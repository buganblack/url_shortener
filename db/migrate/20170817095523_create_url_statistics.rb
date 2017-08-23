class CreateUrlStatistics < ActiveRecord::Migration
  def change
    create_table :url_statistics do |t|
      t.string       :ip_address, null: false
      t.integer      :shorten_url_id, null: false

      t.timestamps
    end

    add_index :url_statistics, :ip_address
    add_index :url_statistics, :shorten_url_id
  end
end
