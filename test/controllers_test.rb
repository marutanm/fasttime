require File.expand_path(File.dirname(__FILE__) + '/test_config.rb')

describe "Controllers" do

  describe "post /time" do
    before { post :time }

    it "create one instance of Stamp" do
      assert last_response.ok?
    end
  end

end
