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

  describe "left_time" do
    let(:stamps){ {} }
    before do
      # 2013/6: work 20 days(160 hours)
      t = Time.local(2013, 6, 10, 10, 0, 0)
      Timecop.travel t

      (1..9).each do |day|
        stamps[day] = OpenStruct.new({working_time: 8.hours})
      end
      stamps[10] = OpenStruct.new(working_time: 4.hours)
    end
    after do
      Timecop.return
    end
    subject { helper.left_time stamps }

    { today:2.5, total:52.5, formated:'84:00' }.each do |method, value|
      it { subject.must_respond_to method }
      it { subject.send(method).must_equal value }
    end
  end

end
