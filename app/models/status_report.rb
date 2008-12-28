class StatusReport < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  before_save :set_status_date
  validates_presence_of :yesterday, :today

  def set_status_date
    self.status_date = Date.today if status_date.nil?
  end
end
