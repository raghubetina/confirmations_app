# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.destroy_all
categories = [
  { name: 'T&E'},
  { name: 'Fixed'},
  { name: 'Callout'}
]
Category.create categories
puts "#{Category.count} categories created."

User.destroy_all
users = [
  { email: 'kyle@kyle.com', first_name: 'Kyle', last_name: 'Weldy', password: 'test', password_confirmation: 'test' },
  { email: 'raghu@raghu.com', first_name: 'Raghu', last_name: 'Betina', password: 'test', password_confirmation: 'test' }
]
User.create users
puts "#{User.count} users created."

ServiceOrder.destroy_all
20.times do
  service_order = {
    category: Category.all.sample,
    description: "Some service order #{rand(100000000)}",
    number: "#{rand(1000)}",
    user: User.all.sample,
    budget: rand(200) + 20
  }
  ServiceOrder.create service_order
end
puts "#{ServiceOrder.count} service orders created."

Confirmation.destroy_all
ServiceOrder.all.each do |service_order|
  (rand(15) + 1).times do
    confirmation = {
      description: "Some confirmation #{rand(100000000)}",
      doubletime_hours: (rand(20) + 1) / 5,
      number: "#{rand(1000)}",
      overtime_hours: (rand(20) + 1) / 5,
      performed_on: Date.today - rand(730),
      service_order: service_order,
      straight_hours: (rand(20) + 1) / 5,
      travel_hours: (rand(20) + 1) / 5,
      user: service_order.user
    }
    Confirmation.create confirmation
  end
end
puts "#{Confirmation.count} confirmations created."

user = User.create email: 'rwbinkley@ra.rockwell.com', first_name: 'Ryan', last_name: 'Binkley', password: 'test', password_confirmation: 'test'
require 'csv'

months = %w(jan feb mar apr may)

months.each do |month|
  CSV.foreach("#{Rails.root}/db/seed_data/#{month}.csv", headers: true) do |row|
    if row["Confirmation"].present?
      so = ServiceOrder.where(:number => row['SO #']).first_or_create(user_id: user.id, category_id: Category.all.sample.id)
      c = Confirmation.new
      c.service_order = so
      c.user = user
      c.description = row['Daily Task']
      c.performed_on = Date.strptime(row['Date'], "%m/%d/%y")
      c.straight_hours = row['Reg Hrs'].to_f
      c.overtime_hours = row['OT Hrs'].to_f
      c.number = row['Confirmation']
      c.save
    end
  end
end

puts "Created confirmations from CSV data."




