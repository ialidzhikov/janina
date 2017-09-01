require 'spec_helper'
require_relative '../support/user_support'

RSpec.configure do |config|
  config.include UserSupport
end

RSpec.describe 'lectures', type: :feature do
  def lecture(name, content, date)
    admin = create :admin
    login(admin.e_mail, admin.password)

    visit '/lecture/add'

    within 'form' do
      fill_in 'Name', with: name
      attach_file 'Content', content
      fill_in 'Date', with: date
    end

    click_button 'Add'
  end

  context 'does not create lecture' do
    it 'with empty name' do
      lecture('', 'spec/resources/lectures/sample.pdf', '2017-08-30')

      expect(Lecture.count).to eq(0)
      expect(page).to have_content 'Name cannot be empty.'
    end

    it 'with empty content' do
      lecture('Basic Language Constructs', nil, '2017-08-30')

      expect(Lecture.count).to eq(0)
      expect(page).to have_content 'Content cannot be empty.'
    end
  end

  context 'creates lecture' do
    it 'with correct params' do
      lecture('Basic Language Constructs', 'spec/resources/lectures/sample.pdf', '2017-08-30')

      expect(Lecture.count).to eq(1)
      expect(page.current_path).to eq('/lectures')
      expect(page).to have_content 'Basic Language Constructs'
    end
  end
end
