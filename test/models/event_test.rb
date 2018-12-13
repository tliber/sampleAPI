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

require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test "validations" do
  end

  #Scopes
  start_date = DateTime.new(1/1/2011)
  month_later = start_date + 1.month
  week_later = start_date + 1.week
  quarter_later = start_date + 3.months

  test 'weekly' do
    event1 = Event.create(name: 'name1', start: start_date, repeat: Event::WEEKLY)
    event2 = Event.create(name: 'name2', start: start_date + 1.day)

    assert Event.all.count == 2

    assert Event.weekly(week_later).count == 1
    assert Event.weekly(week_later).map(&:id) == [event1.id]

  end

  test 'monthly' do
    event1 = Event.create(name: 'name1', start: start_date, repeat: Event::MONTHLY)
    event2 = Event.create(name: 'name2', start: start_date + 1.day)

    assert Event.all.count == 2

    assert Event.monthly(month_later).count == 1
    assert Event.monthly(month_later).map(&:id) == [event1.id]

  end

  test 'quarterly' do
    event1 = Event.create(name: 'name1', start: start_date, repeat: Event::QUARTERLY)
    event2 = Event.create(name: 'name2', start: start_date + 1.day)

    assert Event.all.count == 2

    assert Event.quarterly(quarter_later).count == 1
    assert Event.quarterly(quarter_later).map(&:id) == [event1.id]

  end

  test 'recurring' do
    event1 = Event.create(name: 'name2', start: start_date + 1.day)
    event2 = Event.create(name: 'name2', start: start_date + 3.day)
    event3 = Event.create(name: 'name1', start: start_date, repeat: Event::DAILY)
    event4 = Event.create(name: 'name1', start: quarter_later - 1.week, repeat: Event::WEEKLY)
    event5 = Event.create(name: 'name1', start: start_date, repeat: Event::QUARTERLY)

    assert Event.recurring(quarter_later).map(&:id) == [event3.id, event4.id, event5.id]
  end

end
