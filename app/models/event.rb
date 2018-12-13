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
    start_time = date.beginning_of_day
    end_time = date.end_of_day

    where(start: start_time..end_time).
        daily(start_time)
  end

  # TODO refactor to do all in one query
  scope :recurring, -> (date=DateTime.now.beginning_of_day) do
    events = []

    events.concat daily(date)
    events.concat weekly(date)
    events.concat monthly(date)
    events.concat quarterly(date)

    events
  end


  scope :daily, -> (date=DateTime.now.beginning_of_day) do
    where("repeat = ? AND start <= ?", DAILY, date)
  end

  scope :weekly, -> (date=DateTime.now.beginning_of_day) do
    weekly_events = where("repeat = ? AND start <= ?", WEEKLY, date)

    # TODO Sqlize
    weekly_events_for_date = weekly_events.map do | we |
      if we.start.strftime("%A") != date.strftime("%A")
        we
      end
    end

    weekly_events_for_date
  end

  scope :monthly, -> (date=DateTime.now.beginning_of_day) do
    monthly_events = where("repeat =? AND start <= ?", MONTHLY, date)

    # TODO Sqlize
    monthly_events_for_date = monthly_events.map do | me |
      if me.start.strftime("%d") == date.strftime("%d")
        me
      end
    end

    monthly_events_for_date
  end

  scope :quarterly, -> (date=DateTime.now.beginning_of_day) do
    quarterly_events = where("repeat = ? AND start <= ?", QUARTERLY, date)

    # TODO Sqlize

    quarterly_events_for_date = quarterly_events.map do | qe |
      if quarterly_dates(date).include?(qe.start.strftime("%m %d"))
        qe
      end
    end

    quarterly_events_for_date
  end

  # Class Methods
  # TODO extract into datetime helper module
  def self.quarterly_dates(date)
    [date, date + 3.months, date + 6.months, date + 9.months].map { | d | d.strftime("%m %d") }
  end
end
