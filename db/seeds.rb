User.delete_all
Tour.delete_all
Invitation.delete_all
TourStop.delete_all
Vote.delete_all

text1 = "WRONG. Your ears you keep and I'll tell you why. So that every shriek 
         of every child at seeing your hideousness will be yours to cherish. 
         Every babe that weeps at your approach, every woman who cries out, 
         \"Dear God! What is that thing,\" will echo in your perfect ears. That 
         is what to the pain means. It means I leave you in anguish, wallowing 
         in freakish misery forever."
         
text2 = "You truly love each other and so you might have been truly happy. 
         Not one couple in a century has that chance, no matter what the story 
         books say. And so I think no man in a century will suffer as greatly 
         as you will."

admin = User.create!(name: 'Admin',
                     email: 'admin@puborbar.com',
                     password: 'asdf',
                     password_confirmation: 'asdf',
                     admin: true)

50.times do |user|
  User.create!(name: Faker::Name.name,
               email: Faker::Internet.email,
               password: 'asdf',
               password_confirmation: 'asdf')
end

10.times do |city|
  lat, lng = Faker::Address.latitude, Faker::Address.longitude
  _city = City.create!(name: Faker::Address.city,
                       latitude: lat,
                       longitude: lng)
  
  30.times do |venue|
    address = [Faker::Address.street_address,
               _city.name,
               "#{Faker::Address.state} #{Faker::Address.zip}"].join(', ')
    Venue.create!(name: Faker::Company.name,
                  city: _city,
                  latitude: lat + rand(-0.5..0.5),
                  longitude: lng + rand(-0.5..0.5),
                  address: address,
                  phone_number: Faker::Number.number(10),
                  stars: [1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0].sample,
                  rating_count: rand(3000),
                  image_url: )
  end
end

30.times do |tour|
  city_offset = rand(City.count)
  user_offset = rand(User.count)
  time = rand(2..20)
  _tour = Tour.create!(name: Faker::Lorem.sentence(rand(1..4), false, 0),
                       city: City.offset(city_offset).first!,
                       starting_at: time.weeks.from_now,
                       organizer: User.offset(user_offset).first!,
                       description: Faker::Lorem.paragraph(rand(6), false, 0))
                       
  User.where.not(email: _tour.organizer.email).limit(user_offset).order("RAND()").each do |user|
    Invitation.create!(user: user, tour: _tour)
  end
end


Venue.create!(name: "Asgard",
              city: bos,
              latitude: 42.362593,
              longitude: -71.099572,
              stars: 3.0,
              rating_count: 401,
              image_url: "http://s3-media1.fl.yelpcdn.com/bphoto/eW7xaL7SVfEfNoNqPVBSYg/90s.jpg",
              yelp_id: "1")
Venue.create!(name: "Cuchi Cuchi",
              city: bos,
              latitude: 42.3644454,
              longitude: -71.103187,
              stars: 4.0,
              rating_count: 719,
              image_url: "http://s3-media1.fl.yelpcdn.com/bphoto/G1YbYlJ7DaeHHi_A8MdBBg/90s.jpg",
              yelp_id: "2")
Venue.create!(name: "Church",
              city: bos,
              latitude: 42.342416,
              longitude: -71.099463,
              stars: 3.5,
              rating_count: 290,
              image_url: "http://s3-media2.fl.yelpcdn.com/bphoto/S7uHcAr5d9aLm0yggsvLyg/90s.jpg",
              yelp_id: "3")
Venue.create!(name: "Drink",
              city: bos,
              latitude: 42.350686,
              longitude: -71.048465,
              stars: 4.0,
              rating_count: 1004,
              image_url: "http://s3-media1.fl.yelpcdn.com/bphoto/RlaxnJDwNi8GNSCRvEOT-w/90s.jpg",
              yelp_id: "4")
Venue.create!(name: "Green Street",
              city: bos,
              latitude: 42.3646,
              longitude: -71.104169,
              stars: 4.0,
              rating_count: 528,
              image_url: "http://s3-media2.fl.yelpcdn.com/bphoto/kFpc_qwM3Mj-p6EZf-_goQ/90s.jpg",
              yelp_id: "5")
Venue.create!(name: "Casa Mezcal",
              city: nyc,
              latitude: 40.717925,
              longitude: -73.990117,
              stars: 3.5,
              rating_count: 203,
              image_url: "http://s3-media3.fl.yelpcdn.com/bphoto/lRDkw5ydOm_wHiFVaCRRjg/90s.jpg",
              yelp_id: "6")
Venue.create!(name: "Night of Joy",
              city: nyc,
              latitude: 40.716992,
              longitude: -73.950029,
              stars: 4.0,
              rating_count: 111,
              image_url: "http://s3-media4.fl.yelpcdn.com/bphoto/h0NOJUsG6wj7waJ7-awEWQ/90s.jpg",
              yelp_id: "7")
Venue.create!(name: "PDT",
              city: nyc,
              latitude: 40.727086,
              longitude: -73.983795,
              stars: 4.0,
              rating_count: 1001,
              image_url: "http://s3-media3.fl.yelpcdn.com/bphoto/ty5mvTN5mrR60g4_6b2JPA/90s.jpg",
              yelp_id: "8")
Venue.create!(name: "VU Rooftop Bar",
              city: nyc,
              latitude: 40.747705,
              longitude: -73.986457,
              stars: 3.5,
              rating_count: 166,
              image_url: "http://s3-media3.fl.yelpcdn.com/bphoto/QLx3Opn2T3qokXaIkdrB9g/90s.jpg",
              yelp_id: "9")
Venue.create!(name: "Smuggler's Cove",
              city: sfo,
              latitude: 37.779409,
              longitude: -122.423257,
              stars: 4.0,
              rating_count: 914,
              image_url: "http://s3-media1.fl.yelpcdn.com/bphoto/YuIisBIQVuS07vCPitwdJA/90s.jpg",
              yelp_id: "10")
Venue.create!(name: "The Ice Cream Bar",
              city: sfo,
              latitude: 37.766463,
              longitude: -122.450209,
              stars: 4.0,
              rating_count: 711,
              image_url: "http://s3-media1.fl.yelpcdn.com/bphoto/Lcoj78i8t7QM8D7wrBFI1Q/90s.jpg",
              yelp_id: "11")
Venue.create!(name: "Zeitgeist",
              city: sfo,
              latitude: 37.770107,
              longitude: -122.422114,
              stars: 3.5,
              rating_count: 2249,
              image_url: "http://s3-media4.fl.yelpcdn.com/bphoto/IqQrnBMqHUlzLbZpzccYcQ/90s.jpg",
              yelp_id: "12")
              
TourStop.create!(tour: a_tour2,
                 venue: Venue.where(name: "Casa Mezcal").first)
TourStop.create!(tour: a_tour2,
                 venue: Venue.where(name: "Night of Joy").first,
                 status: "yes")
TourStop.create!(tour: a_tour2,
                 venue: Venue.where(name: "PDT").first,
                 status: "no")
                                          
