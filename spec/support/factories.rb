require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do
  factory :student, class: User do
    full_name      'Ashley Cole'
    faculty_number 20722
    e_mail         'a.cole@gmail.com'
    password       '123456'

    factory :student_with_solutions do
      transient do
        solutions_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:solution, evaluator.solutions_count, user: user)
      end
    end
  end

  factory :admin, class: User do
    full_name      'Adam Smith'
    faculty_number 99999
    e_mail         'a.smith@gmail.com'
    password       '123456'
    admin          true
  end

  factory :lecture do
    name 'Basic Language Constructs'
    content {
      Rack::Test::UploadedFile.new(File.join(__dir__, '..', 'resources', 'lectures', 'sample.pdf'), 'application/pdf')
    }
    date Date.today
  end

  factory :task do
    name        'First Task - Find Nemo'
    description '# First Task - Find Nemo'
    deadline    DateTime.now.utc
    max_points  10
  end

  factory :solution do
    association :user, factory: :student
    task
    points 3
  end
end
