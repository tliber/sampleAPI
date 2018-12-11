class EventsController < ApplicationController
  def create
    event = Event.create!(permitted_params['event'])
    render status: 200, message: 'save successfully'
  end

  def destroy
    puts 'Destroy'
  end

  def index
    puts 'Index'
  end

  def update
    puts 'update'
  end

  def show
    puts 'show'
  end

  private
  def permitted_params
    params.permit(:id, :event=> [:name, :start, :end, :repeat, :users => []])
  end
end
