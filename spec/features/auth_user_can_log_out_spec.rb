require 'rails_helper'


describe "Logged In User" do
  it "user can logout" do
    auth_data = {
        'provider': 'github',
        'uid': "12345678",
        'extra': {
          'raw_info': {
            'name': "Pterry",
            'login': "pterrydactal",
            'email': "example@fake.com",
            'image': "fake.jpg"
          }
        },
        'credentials': {
          'token': ENV["GITHUB_KEY"],
          'secret': ENV["GITHUB_SECRET"]
        }
      }

    OmniAuth.config.mock_auth[:github] = auth_data

    visit '/'

    click_link "Login with Github"

    expect(current_path).to eq('/')
    expect(page).to have_content("Hello, Pterry")
    expect(page).to have_link("Logout")

    click_link "Logout"

    expect(current_path).to eq('/')
    expect(page).to have_content("Successfully logged out")
    expect(page).to have_link("Login with Github")
    expect(page).to_not have_link("Logout")
  end
end
