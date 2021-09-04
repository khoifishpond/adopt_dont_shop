FactoryBot.define do
  factory :shelter, class: Shelter do
    name {Faker::Games::Pokemon.unique.location}
    foster_program {true}
    city {Faker::Address.city}
    rank {Faker::Number.within(range: 1..5)}
  end
end