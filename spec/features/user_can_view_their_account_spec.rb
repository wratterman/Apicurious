require 'rails_helper'


describe "Logged In User" do
  it "user can view their account" do

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

    click_link "View Account"

    expect(page).to have_content("Pterry")
    expect(page).to have_content("pterrydactal")
    expect(page).to have_content("example@fake.com")
  end
end
