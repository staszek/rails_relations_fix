require 'helper'

class TestRailsRelationFix< Test::Unit::TestCase
  context "RailsRelationFix tests" do
    setup do
      @user = User.create(:name => "John Rambo") 
      @titanic = @user.movies.create(:name => "Titanic")
    end

    context "Models testing" do
      should "User has movie" do
        assert_equal(@titanic, @user.movies.first)
      end 
    
      should "Movie belongs to user" do
        assert_equal(@user, @titanic.subject)
      end 
    end
  end
end
