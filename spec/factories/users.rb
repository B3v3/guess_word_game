FactoryBot.define do
  factory :user do
    name { 'robot' }
    email { 'dejw@email.com' }
    password { 'rekinludojad' }
    password_confirmation { 'rekinludojad' }
  end

  factory :user1, class: User do
    name { 'robotto' }
    email { 'dejwid@email.com' }
    password { 'rekinludojad' }
    password_confirmation { 'rekinludojad' }
  end
end
