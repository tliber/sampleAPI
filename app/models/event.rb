# == Schema Information
#
# Table name: events
#
#  id         :bigint(8)        not null, primary key
#  start      :datetime
#  end        :datetime
#  name       :text
#  location   :text
#  context    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ApplicationRecord
  has_and_belongs_to_many :users
end
