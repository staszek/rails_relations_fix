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
    
    context "Association bug tests" do      
      should "return empty collection after destroy its only movie" do
        assert_equal([@titanic], @user.movies)
        @user.movies.destroy(@titanic)
        assert_equal([], @user.movies)
      end
    end
    
    context "Counter_cache for polymorhpic association bug test" do
      should "Update movies_count column after adding movie by << or destroing" do
        @user.movies << Movie.create(:name => "Matrix")
        assert_equal(2, @user.reload.movies_count)
        @titanic.destroy
        assert_equal(1, @user.reload.movies_count)
      end
      
      should "Increment counter_cache only once when create" do
        assert_equal(1, @user.reload.movies_count)
      end
      
      should "Refresh size after adding movie by << or destroing" do
        @user.movies << Movie.create(:name => "Matrix")
        assert_equal(2, @user.movies.size)
        @titanic.destroy
        assert_equal(1, @user.movies.size)
      end
    end
  end
end
