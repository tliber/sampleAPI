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
#  repeat     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ApplicationRecord
  # Associations
  has_and_belongs_to_many :users

  # Validations
  validates :start, presence: true
  validates :name, presence: true
  validates :repeat, inclusion: { in: %w(daily weekly monthly quarterly) }

end
