require 'sqlite3'
require 'tadpoll'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :votes do |t|
    t.references :voter
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

  add_index :votes, [:voter_id]

  create_table :voters do |t|
    t.string :name
  end

end

class Voter < ActiveRecord::Base
  is_voter
end

def clean_database
  models = [Tadpoll::Vote, Voter, NotVoter, Votable, NotVotable, VotableCache]
  models.each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end