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

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
