require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(id: 1, email: 'test@test.com', first_name: 'John', last_name: 'Doe', bio: 'Test', password: 'Test123')
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid withou password' do
    @user.password = nil
    refute @user.valid?
    assert_not_nil @user.errors[:password]
  end


end
