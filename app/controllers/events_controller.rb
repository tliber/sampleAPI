class EventsController < ApplicationController
  def create
    event = Event.create!(permitted_params['event'])
    render status: 200, message: 'save successfully'
  end

  def destroy
    event = Event.destroy(permitted_params['id'])
    render status: 200, message: 'destoyed successfully'
  end

  def index
    event = Event.find(permitted_params['id'])
    render status: 200, json: event
  end

  def update
    puts 'update'
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
