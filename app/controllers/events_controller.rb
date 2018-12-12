class EventsController < ApplicationController
  def create
    Event.create!(permitted_params['event'])
    render status: 200, message: 'save successfully'
  end

  def destroy
    Event.destroy(permitted_params['id'])
    render status: 200, message: 'destoyed successfully'
  end

  def index
    event = Event.find(permitted_params['id'])
    render status: 200, json: event
  end

  def update
    event = Event.find(permitted_params['id'])
    if event.present?
      event.update!(permitted_params['event'])
      render status: 200, message: 'updated successfully'
    else
      render status: 404, message: 'Event not found'
    end
  end

  def show
    event = Event.find(permitted_params['id'])
    render status: 200, json: event.as_json
  end

  private
  def permitted_params
    params.permit(:id, :event=> [:name, :start, :end, :repeat, :users => []])
  end
end
