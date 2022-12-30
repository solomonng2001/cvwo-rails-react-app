require "test_helper"

class ThreadPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @thread_page = thread_pages(:one)
  end

  test "should get index" do
    get thread_pages_url, as: :json
    assert_response :success
  end

  test "should create thread_page" do
    assert_difference("ThreadPage.count") do
      post thread_pages_url, params: { thread_page: { body: @thread_page.body, title: @thread_page.title, user_id: @thread_page.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show thread_page" do
    get thread_page_url(@thread_page), as: :json
    assert_response :success
  end

  test "should update thread_page" do
    patch thread_page_url(@thread_page), params: { thread_page: { body: @thread_page.body, title: @thread_page.title, user_id: @thread_page.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy thread_page" do
    assert_difference("ThreadPage.count", -1) do
      delete thread_page_url(@thread_page), as: :json
    end

    assert_response :no_content
  end
end
