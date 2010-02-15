require 'rubygems'
require 'test/unit'
require 'shoulda'
require "mocha"
require "action_controller"
require 'active_resource'
require 'active_record'
require 'active_support'
require "active_record/base"
require "active_record/associations"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rails_relations_fix'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Base.configurations = true
 
ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.string :name
    t.integer :movies_count
  end
  
  create_table :movies do |t|
    t.string :name
    t.string :subject_type
    t.integer :subject_id
  end

end

class Test::Unit::TestCase
  
  class User < ActiveRecord::Base
    has_many :movies, :as => :subject
  end
  
  class Movie < ActiveRecord::Base
    belongs_to :subject, :polymorphic => true, :counter_cache => true
  end
end
