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
  # CONSTANTS
  DAILY='daily'
  WEEKLY='weekly'
  MONTHLY='monthly'
  QUARTERLY='quarterly'

  [DAILY, WEEKLY, MONTHLY, QUARTERLY].freeze

  # Associations
  has_and_belongs_to_many :users

  # Validations
  validates :start, presence: true
  validates :name, presence: true
  validates :repeat, allow_nil: true, inclusion: { in: %w(daily weekly monthly quarterly) }
  # todo validate end time after start time

  # Scopes
  scope :on_date, -> (date=DateTime.now) do
    date = date.to_datetime
    start_time = date.beginning_of_day
    end_time = date.end_of_day

    dates1 = where(start: start_time..end_time)
    dates2 = recurring(start_time)

    dates1 + dates2
  end

  # TODO refactor to do all in one query
  scope :recurring, -> (date=DateTime.now.beginning_of_day) do
    events = []

    events.concat daily(date)
    events.concat weekly(date)
    events.concat monthly(date)
    events.concat quarterly(date)

    if events.present?
      where(id: [events.map(&:id)])
    end
  end


  scope :daily, -> (date=DateTime.now.beginning_of_day) do
    where("repeat = ? AND start <= ?", DAILY, date)
  end

  scope :weekly, -> (date=DateTime.now.beginning_of_day) do
    weekly_events = where("repeat = ? AND start <= ?", WEEKLY, date)

    # TODO Sqlize
    weekly_events_for_date = weekly_events.select do | we |
      we.start.strftime("%A") != date.strftime("%A")
    end

    weekly_events_for_date
  end

  scope :monthly, -> (date=DateTime.now.beginning_of_day) do
    monthly_events = where("repeat =? AND start <= ?", MONTHLY, date)

    # TODO Sqlize
    monthly_events_for_date = monthly_events.select do | me |
      me.start.strftime("%d") == date.strftime("%d")
    end

    monthly_events_for_date
  end

  scope :quarterly, -> (date=DateTime.now.beginning_of_day) do
    quarterly_events = where("repeat = ? AND start <= ?", QUARTERLY, date)

    # TODO Sqlize
    quarterly_events_for_date = quarterly_events.select do | qe |
      quarterly_dates(date).include?(qe.start.strftime("%m %d"))
    end

    quarterly_events_for_date
  end

  # Class Methods
  # TODO extract into datetime helper module
  def self.quarterly_dates(date)
    [date, date + 3.months, date + 6.months, date + 9.months].map { | d | d.strftime("%m %d") }
  end
end
