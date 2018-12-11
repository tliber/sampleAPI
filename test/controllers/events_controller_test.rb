require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  start_time = Time.now
  event_name = 'event_name'
  repeat = 'daily'

  test "creates event" do
    user = User.create(name: 'Bobby')
    params = { event: { name: event_name, start: start_time, repeat: 'daily', users: user.id } }

    post "/events", params: params
    new_event = Event.find_by(name: event_name)

    assert new_event.present?
    # to do test users
  end

  # test "updates event" do
  #
  #   created_event = Event.create!
  #   created_event.exists?
  #
  #   put "/events/#{created_event.id}", params: { article: { title: "can create", body: "article" } }
  #   should be created
  # end

  test "gets events" do
    created_event = Event.create!(name: event_name, start: start_time)

    response = get "/events/#{created_event.id}"

    assert response
  end

  test "destroys event" do
    created_event = Event.create!(name: event_name, start: start_time)
    response =  delete "/events/#{created_event.id}"
    assert !Event.find_by(name: event_name).present?
  end
end
