FactoryBot.define do
  factory :word do
    name { 'magic' }
  end

  factory :word1, class: Word do
    name { 'funny' }
  end
end
