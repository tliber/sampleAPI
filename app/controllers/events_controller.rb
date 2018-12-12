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
    render json: events
  end

  private
  def permitted_params
    params.permit(:id, :event=> [:name, :start, :end, :repeat, :users => []])
  end

  def set_event
    @event ||= Event.find(permitted_params['id'])
  end
end
