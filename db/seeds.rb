User.delete_all
City.delete_all
Tour.delete_all
Invitation.delete_all
Venue.delete_all

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
                       organizer: a)
a_tour2 = Tour.create!(name: "Allison's Tour 2",
                       city: nyc,
                       starting_at: 2.weeks.from_now,
                       organizer: a)
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

Invitation.create!(user: f,
                   tour: a_tour1 )

Venue.create!(name: "Cuchi Cuchi",
              city: bos,
              cid: 1689477049918841054,
              latitude: 42.3644454,
              longitude: -71.103187)
Venue.create!(name: "Church",
              city: bos,
              cid: 8695192912614686141,
              latitude: 42.342416,
              longitude: -71.099463)
Venue.create!(name: "Green Street",
              city: bos,
              cid: 10387650399081603815,
              latitude: 42.3646,
              longitude: -71.104169)
Venue.create!(name: "Casa Mezcal",
              city: nyc,
              cid: 16985826010331309512,
              latitude: 40.717925,
              longitude: -73.990117)
Venue.create!(name: "Night of Joy",
              city: nyc,
              cid: 6207866197253597918,
              latitude: 40.716992,
              longitude: -73.950029)
Venue.create!(name: "PDT",
              city: nyc,
              cid: 11319416621133992007,
              latitude: 40.727086,
              longitude: -73.983795)
Venue.create!(name: "VU Rooftop Bar",
              city: nyc,
              cid: 8244569405170457324,
              latitude: 40.747705,
              longitude: -73.986457)
Venue.create!(name: "Smuggler's Cove",
              city: sfo,
              cid: 3387281518562663773,
              latitude: 37.779409,
              longitude: -122.423257)
Venue.create!(name: "The Ice Cream Bar",
              city: sfo,
              cid: 14028307416290154786,
              latitude: 37.766463,
              longitude: -122.450209)
Venue.create!(name: "Zeitgeist",
              city: sfo,
              cid: 10750210652604664525,
              latitude: 37.770107,
              longitude: -122.422114)
