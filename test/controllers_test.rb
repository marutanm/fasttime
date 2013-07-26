require File.expand_path(File.dirname(__FILE__) + '/test_config.rb')

include Warden::Test::Helpers

def login
  user = Fabricate(:user)
  user.id = user.github_id
  login_as user
end

describe "Controllers" do

  after{ Warden.test_reset! }

  describe "get /" do
    before { get '/' }

    it "show Index" do
      assert_equal 200, last_response.status
    end

    describe "logged in" do
      before do
        login
        get '/'
      end

      it "redirect to list of current year/month" do
        assert_equal 302, last_response.status
      end
    end
  end

  describe "get /[:year]/[:month]" do
    let(:now) { Time.now }
    before do
      get "/#{now.year}/#{now.month}"
    end

    it "redirect" do
      assert_equal 302, last_response.status
    end

    describe "logged in" do
      before do
        login
        get "/#{now.year}/#{now.month}"
      end

      it "redirect to list of current year/month" do
        assert_equal 200, last_response.status
      end
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
