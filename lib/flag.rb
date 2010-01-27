# == Schema Information
# Schema version: 20090605221257
#
# Table name: flags
#
#  id          :integer(4)      not null, primary key
#  person_id   :integer(4)      
#  flagged_id  :integer(4)      
#  status      :string(255)     default("active")
#  created_at  :datetime        
#  updated_at  :datetime        
#  description :text            
#

class Flag < ActiveRecord::Base
  
  belongs_to :person
  belongs_to :flagged
  
  validates_uniqueness_of :person_id, :scope => [:flagged_id]
  
  STATUS = ["active", "reviewed"]
  ACTIVE_STATUS = STATUS[0]
  REVIEWED_STATUS = STATUS[1]
 
  delegate :type,:active_flags,:reviewed_flags, :to=> :flagged
  
  def total_flags
    self.flagged.flags
  end
  
  def flagged_item
    self.flagged.flaggable
  end
  
end
