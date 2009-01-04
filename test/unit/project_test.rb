require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  test "should be able to retrieve projects based on day" do
    actual = projects(:huddle).reports_grouped_by_day
    expected_keys = actual.keys.sort.map{ |d| d.to_s(:db) }
    assert_equal(["2009-01-06", "2009-01-07"], expected_keys)
    assert_equal([status_reports(:aaron_tue).id, status_reports(:quentin_tue).id],
        actual[Date.parse("2009-01-06")].map(&:id))
  end
  
  
end
