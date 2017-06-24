require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should get index' do
    get users_url, as: :json, headers: {'Authorization' => "Token #{@user.token}"}
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: {
          user: {
              bio: @user.bio,
              birth_date: @user.birth_date,
              first_name: @user.first_name,
              last_name: @user.last_name,
              password: @user.password_digest,
              password_confirmation: @user.password_digest
          }
      }, as: :json
    end

    assert_response 201
  end

  test 'should not create user – password not filled' do
    post users_url, params: {
        user: {
            bio: @user.bio,
            birth_date: @user.birth_date,
            first_name: @user.first_name,
            last_name: @user.last_name
        }
    }, as: :json

    assert_response 422
  end

  test 'should show user' do
    get user_url(@user), as: :json, headers: {'Authorization' => "Token #{@user.token}"}
    assert_response :success
  end

  test 'should update user' do
    patch user_url(@user), params: {
        user: {
            bio: @user.bio,
            birth_date: @user.birth_date,
            first_name: @user.first_name,
            id: @user.id,
            last_name: @user.last_name
        }
    }, as: :json, headers: {'Authorization' => "Token #{@user.token}"}
    assert_response 200
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json, headers: {'Authorization' => "Token #{@user.token}"}
    end

    assert_response 204
  end
end
