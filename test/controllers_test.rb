require File.expand_path(File.dirname(__FILE__) + '/test_config.rb')

describe "Controllers" do
  before { get '/example' }

  it "should return 'Hello world!'" do
    assert_equal 'Hello world!', last_response.body
  end
end
