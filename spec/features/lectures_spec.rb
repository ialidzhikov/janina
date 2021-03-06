require 'spec_helper'
require_relative '../support/user_support'

RSpec.configure do |config|
  config.include UserSupport
end

RSpec.describe 'lectures', type: :feature do
  def fill_lecture_form(name, content, date)
    within 'form' do
      fill_in 'Name', with: name
      attach_file 'Content', content
      fill_in 'Date', with: date
    end
  end

  def create_lecture(name, content, date)
    admin = create :admin
    login(admin.e_mail, admin.password)

    visit '/lecture/add'
    fill_lecture_form(name, content, date)

    click_button 'Add'
  end

  def edit_lecture(id, name, content, date)
    admin = create :admin
    login(admin.e_mail, admin.password)

    visit "/lectures/#{id}/edit"
    fill_lecture_form(name, content, date)

    click_button 'Save'
  end

  context 'does not create lecture' do
    it 'with empty name' do
      create_lecture('', 'spec/resources/lectures/sample.pdf', '2017-08-30')

      expect(Lecture.count).to eq(0)
      expect(page).to have_content 'Name cannot be empty.'
    end

    it 'with empty content' do
      create_lecture('Basic Language Constructs', nil, '2017-08-30')

      expect(Lecture.count).to eq(0)
      expect(page).to have_content 'Content cannot be empty.'
    end
  end

  context 'creates lecture' do
    it 'with correct params' do
      create_lecture('Basic Language Constructs', 'spec/resources/lectures/sample.pdf', '2017-08-30')

      expect(Lecture.count).to eq(1)
      expect(page.current_path).to eq('/lectures')
      expect(page).to have_content 'Basic Language Constructs'
    end
  end

  it 'shows lecture' do
    lecture = create :lecture

    visit '/lectures'
    click_link lecture.name
    expect(page.current_path).to eq("/uploads/lectures/#{lecture.id}/lecture.pdf")
  end

  context 'does not edit lecture' do
    it 'with empty name' do
      lecture = create :lecture
      edit_lecture(lecture.id, nil, nil, lecture.date)

      expect(page).to have_content 'Name cannot be empty.'
    end
  end

  context 'edits lecture' do
    it 'with empty content' do
      lecture = create :lecture
      edit_lecture(lecture.id, "#{lecture.name} (Updated)", nil, lecture.date)

      expect(page).to have_content "#{lecture.name} (Updated)"
    end
  end

  it 'deletes lecture' do
    create_lecture('Basic Language Constructs', 'spec/resources/lectures/sample.pdf', '2017-08-30')
    expect(Lecture.count).to eq(1)
    expect(page).to have_content 'Basic Language Constructs'

    page.driver.submit :delete, '/lectures/1', {}

    expect(Lecture.count).to eq(0)
  end
end
