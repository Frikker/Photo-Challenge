# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Achievement.create!([{ name: 'Первые шаги!', description: 'Ты сделал свой первый пост!', points: 5, medal: 'medal_first_posts.png' },
                     { name: 'Уже не маленький', description: 'Сделано 5 постов! Ты молодец!', points: 10, medal: 'second_medal_posts.png' },
                     { name: 'Лучший!', description: 'Ты сделал лучший пост за сутки!', points: 5, medal: 'best_medal.png' },
                     { name: 'Ваще лучший!', description: 'Твои посты лучшие 5 дней подряд!', points: 25, medal: 'best_medal_level_2.png' }])

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
