class CreateUrlStatistics < ActiveRecord::Migration
  def change
    create_table :url_statistics do |t|
      t.string       :ip_address, null:false
      t.integer      :visit, default: 0

      t.timestamps
    end

    add_index :url_statistics, :ip_address
  end
end
