require 'helper'
require 'quench_client'

class TestQuenchClient < Test::Unit::TestCase
  # Replace this with your real tests.
  should "be created with default params" do 
    panthera = QuenchClient::Panthera.new
    assert panthera.application_id = "2"
    assert panthera.application_key = "f7da7c578fa0c4de7b5e37fa7e5018bb"
    assert panthera.base_url = "http://panthera-api.quenchnetworks.net"
  end
  
  should "allow to specify base params" do
    panthera_new = QuenchClient::Panthera.new({:base_url => 'google.com', :application_key => 'dfffg', :application_id => '33'})
    assert panthera_new.application_id = "33"
    assert panthera_new.application_key = "dfffg"
    assert panthera_new.base_url = "google.com"
  end
  
  should "throw an error when illegal method called" do
    panthera = QuenchClient::Panthera.new
    assert_raise RuntimeError do 
      panthera.query('put', '/globalsearch', {:q =>'nikon'}, nil)
    end
  end
  
  should "allow to create a query" do
    panthera = QuenchClient::Panthera.new
    panthera.query('get', '/globalsearch', {:q =>'nikon'}, nil)
  end

end
