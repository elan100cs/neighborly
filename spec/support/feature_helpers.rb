module FeatureHelpers
  def login
    visit new_user_session_path

    within ".login-box" do
      fill_in 'user_email', with: current_user.email
      fill_in 'user_password', with: 'test123'
      find('input.button').click
    end
  end

  def current_user
    @user ||= FactoryGirl.create(:user, password: 'test123', password_confirmation: 'test123')
  end

  def logout
    within '#user-dropdown' do
      click_on 'Log out'
    end
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
