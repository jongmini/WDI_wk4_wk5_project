# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  lat        :decimal(, )
#  lng        :decimal(, )
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  search_str :string
#

class Location < ActiveRecord::Base

	belongs_to :user
end
