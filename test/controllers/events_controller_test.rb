require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  start_time = Time.now
  event_name = 'event_name'
  repeat = 'daily'

  test "creates event" do
    user = User.create(name: 'Bobby')
    params = { event: { name: event_name, start: start_time, repeat: repeat, users: user.id } }

    post "/events", params: params
    new_event = Event.find_by(name: event_name)

    assert new_event.present?
    # to do test users
  end

  test "updates event" do
    event_name2 = 'event_name2'

    created_event = Event.create!(name: event_name, start: start_time)
    assert Event.find_by(name: event_name).present?

    put "/events/#{created_event.id}", params: { event: { name: event_name2 } }
    assert Event.find(created_event.id).name == event_name2
  end

  test "gets event" do
    created_event = Event.create!(name: event_name, start: start_time)

    get "/events/#{created_event.id}"
    assert JSON.parse(response.body)['id'] == created_event.id
  end

  test "gets events at index" do
    Event.create!(name: event_name, start: start_time)
    Event.create!(name: event_name, start: start_time)

    get "/events"

    puts JSON.parse(response.body).count == Event.count
  end

  test "destroys event" do
    created_event = Event.create!(name: event_name, start: start_time)
    delete "/events/#{created_event.id}"

    assert !Event.find_by(name: event_name).present?
  end
end
