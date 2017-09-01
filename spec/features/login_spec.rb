require 'spec_helper'
require_relative '../support/user_support'

RSpec.configure do |config|
  config.include UserSupport
end

RSpec.describe 'login', type: :feature do
  context 'does not log in' do
    it 'with wrong e-mail' do
      create :student

      login('j.smith@gmail.com', '123456')

      expect(page.current_path).to eq '/user/login'
      expect(page).to have_content 'Invalid e-mail or password.'
    end

    it 'with wrong password' do
      student = create :student

      login(student.e_mail, '1234')

      expect(page.current_path).to eq '/user/login'
      expect(page).to have_content 'Invalid e-mail or password.'
    end
  end

  context 'does log in' do
    it 'with correct e-mail and password' do
      student = create :student

      login(student.e_mail, '123456')

      expect(page.current_path).to eq '/'
      expect(page).to have_content student.e_mail
    end
  end
end
