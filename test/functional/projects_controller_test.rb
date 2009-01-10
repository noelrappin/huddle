require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup :login_quentin
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, :project => { }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, :id => projects(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => projects(:one).id
    assert_response :success
  end

  test "should update project" do
    put :update, :id => projects(:one).id, :project => { }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, :id => projects(:one).id
    end

    assert_redirected_to projects_path
  end
  
  test "project timeline index should be sorted correctly" do
    set_current_project(:huddle)
    get :show, :id => projects(:huddle).id
    expected_keys = assigns(:reports).keys.sort.map{ |d| d.to_s(:db) }
    assert_equal(["2009-01-06", "2009-01-07"], expected_keys)
    assert_equal(
        [status_reports(:aaron_tue).id, status_reports(:quentin_tue).id],
        assigns(:reports)[Date.parse("2009-01-06")].map(&:id))
  end
  
  
  test "show should display project timeline" do
    set_current_project(:huddle)
    get :show, :id => projects(:huddle).id
    assert_select "div[id *= day]", :count => 2
    assert_select "div#2009-01-06_day" do
      assert_select "div[id *= report]", :count => 2
      assert_select "div#?", dom_id(status_reports(:quentin_tue))
      assert_select "div#?", dom_id(status_reports(:aaron_tue))
    end
    assert_select "div#2009-01-07_day" do
      assert_select "div[id *= report]", :count => 2
      assert_select "div#?", dom_id(status_reports(:quentin_wed))
      assert_select "div#?", dom_id(status_reports(:aaron_wed))
    end
  end
  
end
