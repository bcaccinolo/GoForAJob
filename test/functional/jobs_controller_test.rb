require File.dirname(__FILE__) + '/../test_helper'

class JobsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_job
    assert_difference('Job.count') do
      post :create, :job => { }
    end

    assert_redirected_to job_path(assigns(:job))
  end

  def test_should_show_job
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_job
    put :update, :id => 1, :job => { }
    assert_redirected_to job_path(assigns(:job))
  end

  def test_should_destroy_job
    assert_difference('Job.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to jobs_path
  end
end
