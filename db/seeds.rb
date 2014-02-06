# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


t = User.create(name:"Thomas", email:"thomas@email.com", password:"password", password_confirmation:"password")
j = User.create(name:"Jennifer", email:"Jennifer@email.com", password:"password", password_confirmation:"password")
l = User.create(name:"Lisa", email:"Lisa@email.com", password:"password", password_confirmation:"password")
to = User.create(name:"Tony", email:"Tony@email.com", password:"password", password_confirmation:"password")
m = User.create(name:"Mark", email:"Mark@email.com", password:"password", password_confirmation:"password")
d = User.create(name:"Danny", email:"Danny@email.com", password:"password", password_confirmation:"password")
s = User.create(name:"Sam", email:"Sam@email.com", password:"password", password_confirmation:"password")

t.locations << Location.create(name:"home")
m.locations << Location.create(name:"work")
m.locations << Location.create(name:"market")
t.locations << Location.create(name:"bank")
m.locations << Location.create(name:"mall")
to.locations << Location.create(name:"BART")
j.locations << Location.create(name:"bus stop")
to.locations << Location.create(name:"school")
to.locations << Location.create(name:"GA")
j.locations << Location.create(name:"gas station")
l.locations << Location.create(name:"laundry")
j.locations << Location.create(name:"pub")
l.locations << Location.create(name:"restaurant")
d.locations << Location.create(name:"work")
s.locations << Location.create(name:"work")
j.locations << Location.create(name:"work")
t.locations << Location.create(name:"work")
to.locations << Location.create(name:"work")





