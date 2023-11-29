# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create(username: "francisco", password: "1234")
user2 = User.create(username: "chico", password: "1234", role: "admin")


survey = Survey.create(title: "Titulo 1", user_id: 2, deadline: Date.today + 5.days)
question = Question.create(name: "Questão 1", survey_id: 1, options_answer: ["Letra A", "Letra B", "Letra C"], type_question: :text)
asnwer = Answer.create(answer: "Responda da questão 1", survey_id: 1, question_id: 1, user_id: 2)
