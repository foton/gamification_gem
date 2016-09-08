require 'test_helper'

module Gamfora
  class PlayerTest < ActiveSupport::TestCase

    test "can be created" do
      player=Gamfora::Player.new(game: gamfora_games(:got), user: users(:user3))
      assert player.save
    end
      
    test "requires game" do 
      player=Gamfora::Player.new(user: users(:user3))
      refute player.save
      refute player.errors[:game].empty?
    end

    test "requires user" do
      #no user id
      player=Gamfora::Player.new(game: gamfora_games(:got))
      refute player.save
      refute player.errors[:user].empty?

      #not existing owner
      player=Gamfora::Player.new(game: gamfora_games(:got), user_id: (User.last.id+1))
      refute player.save
      refute player.errors[:user].empty?
    end 

    test "pass name of user according to settings" do
      player=Gamfora::Player.new(game: gamfora_games(:got), user: users(:user3))
      assert_equal(users(:user3).name, player.name)
      assert_equal(users(:user3).send(Gamfora.player_name_attribute), player.name)
    end  

    test "user cannot have more than one player for game" do
      skip
    end  

  end
end