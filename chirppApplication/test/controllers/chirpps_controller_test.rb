require 'test_helper'

class ChirppsControllerTest < ActionController::TestCase
	setup do
	  session[:current_user_id] = 1
	end

  test 'shows all records when session is not set' do
  	session[:current_user_id] = ""
    get :index

    assert_equal 4, assigns(:chirpps).count
    assert_not_nil assigns(:chirpps)
    assert_response :success
    assert_template :show
  end

   test 'index shows user records when session is set' do
    get :index

    assert_equal 3, assigns(:chirpps).count
    assert_not_nil assigns(:chirpps)
    assert_response :success
    assert_template :index
  end

  test 'index shows other chirpps from other uses as well' do
    get :index

    assert_equal 1, assigns(:other_chirpps).count
  end

  test 'index add a new variable for chirp' do
    get :index

    assert_equal assigns(:chirp).class, Chirpp
  end

  test 'show lists only' do
    session[:current_user_id] = ""
    get :show
    assert_equal 4, assigns(:chirpps).count
  end

  test 'edit loads the correct user details' do
    xhr :get, :edit, :id => 2

    assert_equal chirpps(:two), assigns(:chirp)
    assert_response :success
    assert_template :inline_edit_row
  end

  test 'create saves chirpp to the database' do
    assert_difference 'Chirpp.count', 1 do
      xhr :post, :create, :chirpp => {content: 'hello !!'}
    end
  end

  test 'create redirects to javascript on success' do
    xhr :post, :create, :chirpp => {content: 'hello !!'}

	  assert_response :success
    assert_template :create
  end

  test 'create redirects to javascript on error' do
    xhr :post, :create, :chirpp => {content: ''}

    assert_response :success
    assert_template :create_error
  end

  test 'updates loads the correct chirp details' do
    xhr :put, :update, :id => 2, :chirpp => {content: 'hello !!'}

    assert_equal chirpps(:two), assigns(:chirp)
  end

  test 'updates assigns correct data to the chirp to be updated' do
    xhr :put, :update, :id => 2, :chirpp => {content: 'hello !!'}

    assert_equal assigns(:chirp).content, 'hello !!'
    assert_equal assigns(:chirp).user_profile_id, 1
  end

  test 'updates redirects to javascript file on error' do
    xhr :put, :update, :id => 2, :chirpp => {content: ''}

    assert_response :success
    assert_template :edit_error
  end
  
  test 'destroy deletes chirpps from database' do
     delete :destroy, :id => 3, :chirpp => {content: 'hello !!'}
     assert_redirected_to :controller=>"chirpps", :action => "index"
  end

end
