class EventsController < ApplicationController
  def create
    puts 'Create'
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
  end
end
