FactoryBot.define do
  factory :guess do
    text { "im done" }
    game_room_id { 1 }
  end

  factory :lucky_guess, class: Guess do
    text { 'test room' }
    game_room_id { 1 }
  end
 end
