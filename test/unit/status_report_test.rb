require 'test_helper'

class StatusReportTest < ActiveSupport::TestCase
  
  test "saving a status report saves the status date" do
    actual = StatusReport.new(:today => "t", :yesterday => "y")
    actual.save
    assert_equal(Date.today.to_s, actual.status_date.to_s)
  end
  
  test "saving a status report that already has a date doesn't override" do
    actual = StatusReport.new(:status_date => 10.days.ago)
    actual.save
    assert_equal(10.days.ago.to_s, actual.status_date.to_s)
  end
  
  test "a test with both blank is not valid" do
    actual = StatusReport.new(:today => "", :yesterday => "")
    assert !actual.valid?
  end
  
end
