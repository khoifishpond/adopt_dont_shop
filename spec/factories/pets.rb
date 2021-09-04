FactoryBot.define do
  factory :pet, class: Pet do
    name {Faker::Games::Pokemon.unique.name}
    breed {Faker::Creature::Dog.breed}
    age {Faker::Number.within(range: 1..15)}
    adoptable {Faker::Boolean.boolean}
  end
end