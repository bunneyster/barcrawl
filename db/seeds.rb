User.delete_all
City.delete_all
Tour.delete_all
Invitation.delete_all
Venue.delete_all
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

a = User.create!(name: 'Allison',
                 email: 'a@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')
s = User.create!(name: 'Sam',
                 email: 's@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')
d = User.create!(name: 'Dan',
                 email: 'd@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')
f = User.create!(name: 'Firenze',
                 email: 'f@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')       
q = User.create!(name: 'Quinn',
                 email: 'q@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')  
w = User.create!(name: 'Westley',
                 email: 'w@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')   
e = User.create!(name: 'Erik',
                 email: 'e@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')
r = User.create!(name: 'Ryan',
                 email: 'r@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')
z = User.create!(name: 'Zeinab',
                 email: 'z@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')
x = User.create!(name: 'Xeno',
                 email: 'x@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')       
c = User.create!(name: 'Cat',
                 email: 'c@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')  
v = User.create!(name: 'Viola',
                 email: 'v@asdf.com',
                 password: 'asdf',
                 password_confirmation: 'asdf')                      
             
bos = City.create!(name: 'Boston',
                   latitude: 42.3133735,
                   longitude: -71.0571571)
nyc = City.create!(name: 'New York',
                   latitude: 40.7056308,
                   longitude: -73.9780035)
sfo = City.create!(name: 'San Francisco',
                   latitude: 37.7577,
                   longitude: -122.4376)
sel = City.create!(name: 'Seoul',
                   latitude: 37.5651,
                   longitude: 126.98955)             

a_tour1 = Tour.create!(name: "Allison's Tour 1",
                       city: bos,
                       starting_at: 1.week.from_now,
                       organizer: a,
                       description: text1)
a_tour2 = Tour.create!(name: "Allison's Tour 2",
                       city: nyc,
                       starting_at: 2.weeks.from_now,
                       organizer: a,
                       description: text2)
a_tour3 = Tour.create!(name: "Allison's Tour 3",
                       city: sfo,
                       starting_at: 3.weeks.from_now,
                       organizer: a) 
s_tour1 = Tour.create!(name: "Sam's Tour 1",
                       city: sfo,
                       starting_at: 3.weeks.from_now,
                       organizer: s)
s_tour2 = Tour.create!(name: "Sam's Tour 2",
                       city: sfo,
                       starting_at: 3.weeks.from_now,
                       organizer: s)
d_tour1 = Tour.create!(name: "Dan's Tour 1",
                       city: sel,
                       starting_at: 3.weeks.from_now,
                       organizer: d)    

User.where.not(name: 'Allison').each do |user|
  Invitation.create!(user: user,
                     tour: a_tour1)
end
User.where.not(name: 'Sam').each do |user|
  Invitation.create!(user: user,
                     tour: s_tour1)
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
                                          
