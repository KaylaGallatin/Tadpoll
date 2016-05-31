class TadpollMigration < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.references :voter
      t.belongs_to :poll, index: true
      t.belongs_to :option, index: true

      t.timestamps
    end

    create_table :polls do |t|
      t.string :name

      t.timestamps
    end

    create_table :options do |t|
      t.string :name
      t.belongs_to :poll, index: true

      t.timestamps
    end

    add_index :votes, [:voter_id]
  end

  def self.down
    drop_table :votes
    drop_table :polls
    drop_table :options
  end
end