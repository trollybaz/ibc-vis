class Person < ActiveRecord::Base
  belongs_to :family

  before_save :set_name

  attr_accessor :name

  attr_accessible :first_name, :middle_name, :last_name, :family_id, :description, :status, :name

  # statuses; 0 - guest; 1 - member; 2 - ex-member 3; 4 - nonactive guest; 5 - member's kid

  def set_name 
    if self.name.present?
      parts = name.split(/\s+/)  
      if parts.size > 1
        self.first_name = parts[0]
        self.last_name = parts[1..(parts.size-1)].join(' ')
      elsif parts.size == 1
        self.last_name = parts[0]  
      end
    end
  end
end
