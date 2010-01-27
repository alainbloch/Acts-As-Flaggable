# == Schema Information
# Schema version: 20090605221257
#
# Table name: flaggeds
#
#  id             :integer(4)      not null, primary key
#  flaggable_id   :integer(4)      
#  flaggable_type :string(255)     
#  status         :string(255)     default("active")
#  created_at     :datetime        
#  updated_at     :datetime        
#  reviewer_id    :integer(4)      
#

class Flagged < ActiveRecord::Base
  belongs_to :flaggable, :polymorphic => true
  belongs_to :reviewer,  :class_name  => "User"
  
  has_many :flags
  has_many :active_flags,   :class_name => "Flag", :conditions => "status = '#{Flag::ACTIVE_STATUS}'"
  has_many :reviewed_flags, :class_name => "Flag", :conditions => "status = '#{Flag::REVIEWED_STATUS}'"
  
  validates_uniqueness_of :flaggable_id, :scope => [:flaggable_type]
  
  STATUS = ["active", "reviewed"]
  ACTIVE_STATUS = STATUS[0]
  REVIEWED_STATUS = STATUS[1]
  
  
  def type
    return "Action" if self.flaggable.type.to_s.include?("Action")
    self.flaggable.type.to_s
  end
  
  def most_recent_flag
    self.flags.sort_by{|flag| flag.created_at}.last
  end
end
