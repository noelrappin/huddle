class StatusReport < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  before_save :set_status_date
  validate :validate_has_at_least_one_status
  
  named_scope :by_user_name, :include => "user", :order => "users.email ASC",
      :conditions => "user_id NOT NULL"

  def validate_has_at_least_one_status
    if today.blank? and yesterday.blank?
      errors.add_to_base("Must have at least one status set")
    end 
  end

  def set_status_date
    self.status_date = Date.today if status_date.nil?
  end
end
