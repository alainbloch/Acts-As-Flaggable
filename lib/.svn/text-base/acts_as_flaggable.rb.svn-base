module ActsAsFlaggable

  # Mix below class methods
  def self.included(base) # :nodoc:
    base.extend ClassMethods
  end
  
  module ClassMethods

    def acts_as_flaggable
      has_one :flagged, :as => :flaggable, :dependent => :destroy
      include ActsAsFlaggable::FlaggingMethods
    end
    
  end

  module FlaggingMethods
  
    def flags
      self.flagged.flags
    end
  
    def active_flags 
      self.flagged.active_flags
    end
  
    def reviewed_flags
      self.flagged.reviewed_flags
    end
  
    def review_flags(options = {})
      reviewer = options[:reviewer]
      self.flagged.status = Flagged::REVIEWED_STATUS
      self.flagged.reviewer = reviewer
      self.flagged.save
      self.flagged.active_flags.each do |flag|
        flag.status = Flag::REVIEWED_STATUS
        flag.save
      end
    end
  
  end
  
end