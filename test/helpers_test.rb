require File.expand_path(File.dirname(__FILE__) + '/test_config.rb')
require File.expand_path(Padrino.root + '/app/helpers.rb')

describe AppHelper do

  let(:helper) do
    helper = Object.new
    helper.extend AppHelper
  end

  describe "format_time" do
    it 'format HH:MM' do
      helper.format_time(0).must_equal '-'
      1.upto(59).each do |i|
        helper.format_time(i).must_equal '00:00'
      end
      60.upto(119).each do |i|
        helper.format_time(i).must_equal '00:01'
      end
      helper.format_time(120).must_equal '00:02'
      helper.format_time(3599).must_equal '00:59'
      helper.format_time(3600).must_equal '01:00'
    end
  end

end
