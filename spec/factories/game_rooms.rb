FactoryBot.define do
  factory :game_room do
    name { 'test room' }
    description { 'place where you try things'}
    user_id { 1 }
  end

  factory :game_room1, class: GameRoom do
    name { 'fun room' }
    description {'place where you have a good time'}
    user_id { 1 }
  end
end
