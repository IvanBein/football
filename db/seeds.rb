# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
array = ["David", "Ivan", "Petr", "Vladislav", "Arman", "Kostia", "Vladimir", "Ilua", "Vsevolod", "Roman", "Nikita", "Egor", "Kirill", "Aleksandr", "Anton"]
hash_bool={0=> true, 1 => false}
i=0
loop do
i+=1
a=rand(2)
player = Player.create(name: array[rand(array.size)], goals: rand(10),ready: hash_bool.fetch(a))
break if i==10000
end