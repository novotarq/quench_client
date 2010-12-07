require 'helper'

class TestQuenchClient < Test::Unit::TestCase

  should "allow to load options and return a Hash" do    
    QuenchClient.load_options
    response = QuenchClient.search('nikon')
    assert_not_nil response
    assert_instance_of Hash, response
  end
end
