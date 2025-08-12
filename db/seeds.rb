# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

editor = Editor.create!(email: "editor@example.com", password: "Password123")

Episode.create!(
  title: "حلقة تجريبية",
  description: "وصف بسيط للحلقة",
  duration: 1200,
  published_at: 2.days.ago,
  source_url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
  editor: editor
)
