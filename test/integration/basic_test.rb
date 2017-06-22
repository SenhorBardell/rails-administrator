require 'test_helper'

class BasicTest < ActionDispatch::IntegrationTest

  test 'can see index page' do
    visit '/'
    print page.html
  end

end