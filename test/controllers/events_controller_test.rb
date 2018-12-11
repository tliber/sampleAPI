require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "creates event" do
     post "/events", params: { article: { title: "can create", body: "article" } }
     # should be created
  end

  test "updates event" do
    put "/events/1", params: { article: { title: "can create", body: "article" } }
    # should be created
  end

  test "gets events" do
    get "/events", params: { article: { title: "can create", body: "article" } }
    # test "gets events within a certain time range" do
    # end
    #
    # test "gets events for specific user" do
    # end
  end

  test "destroys event" do
    delete "/events/1", params: { article: { title: "can create", body: "article" } }
  end
end
