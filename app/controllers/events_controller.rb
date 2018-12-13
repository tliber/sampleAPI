class EventsController < ApplicationController
  before_action :set_event, only: [:destroy, :update, :show]


  def create
    Event.create!(permitted_params['event'])

    render json: {status: 200, message: 'saved successfully'}
  end

  def destroy
    @event.destroy!
    render json: { status: 200, message: 'destroyed successfully' }
  end

  def update
    @event.update!(permitted_params['event'])
    render json: { status: 200, message: 'updated successfully' }
  end

  def show
    render json: @event
  end

  def index
    events = Event.all

    if has_date_range?
      events_in_date_range = events.within_date_range(start_date: permitted_params['start_date'], end_date: permitted_params['end_date'])
      render json: events_in_date_range
    else
      render json: events
    end
  end

  private
  def permitted_params
    params.permit(:id, :start_date, :end_date, :event=> [:name, :start, :end, :repeat, :users => []])
  end

  def set_event
    @event ||= Event.find(permitted_params['id'])
  end

  def has_date_range?
    permitted_params['start_date'] || permitted_params['end_date']
  end
end
