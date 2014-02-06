# == Schema Information
#
# Table name: waypoints
#
#  id         :integer          not null, primary key
#  way_lat    :decimal(, )
#  way_lng    :decimal(, )
#  journey_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Waypoint < ActiveRecord::Base
	belongs_to :journey
end
