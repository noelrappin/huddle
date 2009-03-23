class Project < ActiveRecord::Base
  
  has_many :status_reports
  has_and_belongs_to_many :users
  
  def reports_grouped_by_day
    status_reports.by_user_name.group_by(&:status_date)
  end
  
end
