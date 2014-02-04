# == Schema Information
#
# Table name: journeys
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  origin      :string(255)
#  orig_lat    :decimal(, )
#  orig_lng    :decimal(, )
#  destination :string(255)
#  dest_lat    :decimal(, )
#  dest_lng    :decimal(, )
#  user_id     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Journey < ActiveRecord::Base

	belongs_to :user
	has_many :waypoints
end
