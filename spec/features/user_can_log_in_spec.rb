require 'rails_helper'


describe "User Logs In" do
  it "user can login through git" do
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

      no_auth_data = {
          'provider': 'github',
          'uid': "12345678",
          'extra': {
            'raw_info': {
              'name': "Andy Smith-Schefter",
              'login': "asmith",
              'email': "ass@fake.com",
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

    expect(current_path).to eq(root_path)
    expect(page).to have_link("Login with Github")
    expect(page).to_not have_content("Hello, Pterry")
    expect(page).to_not have_link("Logout")

    click_link "Login with Github"

    expect(current_path).to eq('/')
    expect(page).to have_content("Hello, Pterry")
    expect(page).to_not have_content("Hello, Andy Smith-Schefter")
    expect(page).to have_link("Logout")
    expect(page).to_not have_link("Login with Github")
  end
end
