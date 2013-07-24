require File.expand_path(File.dirname(__FILE__) + '/test_config.rb')

describe "Controllers" do

  describe "get /" do
    before { get '/' }

    it "redirect to list of current year/month" do
      assert_equal 200, last_response.status
    end
  end

  describe "get /list/[:year]/[:month]" do
    before { skip }
    before do
      now = Time.now
      get "/list/#{now.year}/#{now.month}"
    end

    it "Success" do
      assert last_response.ok?
    end
  end

  describe "post /time" do
    before { skip }
    before { post :time }

    it "create one instance of Stamp" do
      assert last_response.ok?
    end
  end

end
