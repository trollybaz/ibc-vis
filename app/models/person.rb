class Person < ActiveRecord::Base
  belongs_to :family

  attr_accessible :first_name, :middle_name, :last_name, :family_id, :description, :status
end
