require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Stamp Model" do
  it 'can construct a new instance' do
    @stamp = Stamp.new
    refute_nil @stamp
  end
end
