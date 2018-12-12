class EventsController < ApplicationController
  before_action :set_event, only: [:destroy, :update, :show]

  def create
    Event.create!(permitted_params['event'])
    render status: 200, message: 'save successfully'
  end

  def destroy
    @event.destroy!
    render status: 200, message: 'destoyed successfully'
  end

  def update
    @event.update!(permitted_params['event'])
    render status: 200, message: 'updated successfully'
  end

  def show
    render status: 200, json: @event
  end

  def index
    events = Event.all
    render status: 200, json: events
  end

  private
  def permitted_params
    params.permit(:id, :event=> [:name, :start, :end, :repeat, :users => []])
  end

  def set_event
    @event ||= Event.find(permitted_params['id'])
  end
end
