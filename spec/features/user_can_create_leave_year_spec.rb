require 'rails_helper'

RSpec.feature 'A user can create a new leave_year', type: :feature do
  scenario do
    login_with_oauth
    expect(page).to have_text "Profile for Colin Bruce"
  end
end
