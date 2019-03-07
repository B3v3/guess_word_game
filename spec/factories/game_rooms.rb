FactoryBot.define do
  factory :game_room do
    name { 'test room' }
  end

  factory :game_room1, class: GameRoom do
    name { 'fun room' }
  end
end
