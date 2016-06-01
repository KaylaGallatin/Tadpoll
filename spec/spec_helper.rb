require 'sqlite3'
require 'tadpoll'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :votes do |t|
    t.references :voter, polymorphic: true
    t.belongs_to :poll, index: true
    t.belongs_to :option, index: true
    t.timestamps null: false
  end

  create_table :polls do |t|
    t.string :name
    t.timestamps null: false
  end

  create_table :options do |t|
    t.string :name
    t.belongs_to :poll, index: true
    t.timestamps null: false
  end

  add_index :votes, [:voter_id, :voter_type]

  create_table :users do |t|
    t.string :name
  end

end

class User < ActiveRecord::Base
  is_voter
end

def clean_database
  models = [Tadpoll::Vote, Tadpoll::Poll, Tadpoll::Option, User]
  models.each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end