require 'test_helper'

class UserprofilesControllerTest < ActionController::TestCase

	test 'new assigns userprofile model and renders new page' do
	    get :new

	    assert_not_nil assigns(:user)
	    assert_response :success
	    assert_template :new
	 end

  test 'create saves user to the database' do
    assert_difference 'UserProfile.count', 1 do
     xhr :post, :create, :username => 'willis', :password => 'Abcde@123',:user_profile => {first: 'Smith', last: 'Williams', email: 'swilliams2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498'}
    end
  end

  test 'create saves user login to the database' do
    assert_difference 'UserLogin.count', 1 do
      xhr :post, :create, :username => 'willis', :password => 'Abcde@123',:user_profile => {first: 'Smith', last: 'Williams', email: 'swilliams2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498'}
    end
  end

  test 'create saves user and redirect to create.erb.js to the database' do
     xhr :post, :create, :username => 'willis', :password => 'Abcde@123',:user_profile => {first: 'Smith', last: 'Williams', email: 'swilliams2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498'}
     assert_response :success
     assert_template :create
  end

  test 'create invalid user should render new' do
    post :create, :username => 'willis', :password => 'Abcde@123',:user_profile => {first: '', last: 'Williams', email: 'swilliams2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498'}

    assert_not_nil assigns(:user).errors
    assert_response 302
    assert_redirected_to "http://test.host/userprofiles/new"
  end

  test 'create invalid user ajax should take to create error javascript file' do
    xhr :post, :create, :username => 'willis', :password => 'Abcde@123',:user_profile => {first: '', last: 'Williams', email: 'swilliams2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498'}

    assert_not_nil assigns(:user).errors
    assert_response :success
    assert_template :create_error
  end

  test 'create invalid username and password ajax should revert change to user_profile changes' do
    assert_difference 'UserProfile.count', 0 do
      xhr :post, :create, :username => '', :password => '',:user_profile => {first: 'Smith', last: 'Williams', email: 'swilliams2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498'}
    end
  end

  test 'create invalid username and password ajax should take to create error javascript file' do
    xhr :post, :create, :username => '', :password => '',:user_profile => {first: 'Smith', last: 'Williams', email: 'swilliams2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498'}

    assert_not_nil assigns(:user_login).errors
    assert_response :success
    assert_template :create_error
  end

  test 'edit loads the correct user details' do
    session[:current_user_id] = 2
    get :edit, :id => 2

    assert_equal user_profiles(:two), assigns(:user)
    assert_equal user_logins(:two).username, assigns(:username)
    assert_equal user_logins(:two).password, assigns(:password)
    assert_response :success
    assert_template :edit
  end

  test 'updates loads the correct user details' do
    xhr :put, :update, :id => 2, :username => "taso", :password => 'Abcde@123', :user_profile => {first: 'Smith', last: 'Williams', email: 'swilliams2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498'}

    assert_equal user_profiles(:two), assigns(:user)
    assert_equal user_logins(:two), assigns(:user_login)
 end

test 'updates redirects to error in case of error in user data' do
    xhr :put, :update, :id => 2, :username => "taso", :password => 'Abcde@123', :user_profile => {first: '', last: 'Williams', email: 'swilliams2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498'}

    assert_response :success
    assert_template :create_error
 end

 test 'updates redirects to error in case of error in username or password' do
    xhr :put, :update, :id => 2, :username => "", :password => 'Abcde@123', :user_profile => {first: 'Smith', last: 'Williams', email: 'swilliams2@email.com', phone: 4049746590, addline1: 'west aiprt blvd', addline2: '', street: 'Street1', city: 'SugarLand', country: 'USA', pincode: '77498'}

    assert_response :success
    assert_template :create_error
 end

end
