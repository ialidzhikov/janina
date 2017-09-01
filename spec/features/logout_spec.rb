require 'spec_helper'
require_relative '../support/user_support'

RSpec.configure do |config|
  config.include UserSupport
end

RSpec.describe 'logout', type: :feature do
  describe 'logouts' do
    it 'after login' do
      student = create :student

      login(student.e_mail, '123456')
      expect(page).to have_content student.e_mail

      click_link('Logout')
      expect(page).to have_content 'Login'
      expect(page).to have_no_content student.e_mail
    end

    it 'after registration' do
      register('Ashley Cole', 20700, 'a.cole@gmail.com', '123456', '123456')
      expect(page).to have_content 'a.cole@gmail.com'

      click_link('Logout')
      expect(page).to have_content 'Login'
      expect(page).to have_no_content 'a.cole@gmail.com'
    end
  end
end
