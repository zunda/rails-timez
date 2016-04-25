class CreateTimestamps < ActiveRecord::Migration
  def change
    create_table :timestamps do |t|

      t.timestamps
    end
  end
end
