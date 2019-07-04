# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(registration: "12334",name: "Admin", kind: :admin, job_role: :admin_user, birthdate: Time.now,
             phone: "12997245865", :addresses_attributes => [street: "street", number: "number",city: "city",
                                                         state: "SP", zip_code: "11680-000", neighboard: "bairro"],
             email: 'admin@example.com', password: 'password', password_confirmation: 'password')