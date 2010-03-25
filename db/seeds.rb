puts "==  Seeding Database: seeding ================================================="
timeall = Time.now.to_f

# create a user in script/console and copy hashed_password and salt to here,
# or use :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871"
# for the password 'bunnies'
users = true
time = Time.now.to_f
puts "-- seeding Users"
users = users && User.create(:name => "sewillia", :hashed_password => "f14ca870cf00d6ba27a2f9effbb035b69b642bae", :salt => "21743334400.149901635588873")
users = users && User.create(:name => "jrfriedr", :hashed_password => "95c7eef0800d977b4e7affb9530e9e4c84add60e", :salt => "21730906600.43768004484198")
users = users && User.create(:name => "amgross", :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871")
users = users && User.create(:name => "dfreeman", :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871")
users = users && User.create(:name => "achivett", :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871")
users = users && User.create(:name => "mdickoff", :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871")
users = users && User.create(:name => "tsnider", :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871")
if users
  puts "   -> #{(Time.now.to_f-time).to_s[0..5]}s"
else
  puts "   error seeding Users"
end


# need crud(c|r|u|d)(content|show|user|update|role(assoc)?|ticket(alert|rez|section))s
roles = true
time = Time.now.to_f
puts "-- seeding Roles"
# contents, shows, users, updates, roles, roleassocs, ticketalerts, ticketrezs, ticketsections, rezlineitems
roles = roles && Role.create(:rname => "Administrator", :rabbrev => "admin", :rcontents => "crud", :rshows => "crud", :rusers => "crud", :rupdates => "crud", :rroles => "crud", :rroleassocs => "crud", :rticketalerts => "crud", :rticketrezs => "crud", :rticketsections => "crud", :rrezlineitems => "crud")
roles = roles && Role.create(:rname => "Developer", :rabbrev => "dev", :rshows => "crud", :rupdates => "crud", :rroles => "crud", :rroleassocs => "crud", :rticketalerts => "crud", :rticketrezs => "crud", :rticketsections => "crud", :rrezlineitems => "crud")
roles = roles && Role.create(:rname => "Content writer", :rabbrev => "writer", :rcontents => "crud", :rshows => "crud", :rupdates => "crud", :rticketsections => "crud")
roles = roles && Role.create(:rname => "Ticketmaster", :rabbrev => "tixer", :rshows => "crud", :rticketalerts => "crud", :rticketrezs => "crud", :rticketsections => "crud", :rrezlineitems => "crud")
if roles
  puts "   -> #{(Time.now.to_f-time).to_s[0..5]}s"
else
  puts "   error seeding Roles"
end

time = Time.now.to_f
puts "-- seeding Roleassocs"
roleassocs = true
roleassocs = roleassocs && Roleassoc.create(:roleid => "admin", :userid => "sewillia")
roleassocs = roleassocs && Roleassoc.create(:roleid => "dev", :userid => "sewillia")
roleassocs = roleassocs && Roleassoc.create(:roleid => "dev", :userid => "amgross")
roleassocs = roleassocs && Roleassoc.create(:roleid => "dev", :userid => "dfreeman")
roleassocs = roleassocs && Roleassoc.create(:roleid => "dev", :userid => "achivett")
roleassocs = roleassocs && Roleassoc.create(:roleid => "dev", :userid => "mdickoff")
roleassocs = roleassocs && Roleassoc.create(:roleid => "writer", :userid => "sewillia")
roleassocs = roleassocs && Roleassoc.create(:roleid => "writer", :userid => "jrfriedr")
roleassocs = roleassocs && Roleassoc.create(:roleid => "writer", :userid => "amgross")
roleassocs = roleassocs && Roleassoc.create(:roleid => "writer", :userid => "tsnider")
roleassocs = roleassocs && Roleassoc.create(:roleid => "tixer", :userid => "sewillia")
roleassocs = roleassocs && Roleassoc.create(:roleid => "tixer", :userid => "jrfriedr")
roleassocs = roleassocs && Roleassoc.create(:roleid => "tixer", :userid => "amgross")
roleassocs = roleassocs && Roleassoc.create(:roleid => "tixer", :userid => "tsnider")
if roleassocs
  puts "   -> #{(Time.now.to_f-time).to_s[0..5]}s"
else
  puts "   error seeding Roleassocs"
end

# fields: name, shortdisplayname, abbrev, loc, imageurl, author, performancetimes, ticketstatus, director, timesvisible
# required: name, shortdisplayname, abbrev, imageurl, ticketstatus, performancetimes, timesvisible
#Show.create(
# :name => "",
# :abbrev => "",
# :imageurl => "",
# :ticketstatus => "",
# :performancetimes => "",
# :timesvisible => 
#)
time = Time.now.to_f
puts "-- seeding Shows"
shows = true
shows = shows && Show.create(:name => "Scotch On The Rocks (With a Twist)", :shortdisplayname => "Scotch on the Rocks", :abbrev => "sotrwat", :imageurl => "sotrwat.png", :performancetimes => "May 2 2008, 7PM|May 3 2008, 7PM", :timesvisible => true, :ticketstatus => "completed")
shows = shows && Show.create(:name => "Scotch Straight Up", :shortdisplayname => "Scotch Straight Up", :abbrev => "ssu", :imageurl => "ssu.png", :performancetimes => "May 2 2008, 9PM|May 3 2008, 9PM", :timesvisible => true, :ticketstatus => "completed")
shows = shows && Show.create(:name => "A Funny Thing Happened On The Way To The Forum", :shortdisplayname => "Forum", :abbrev => "forum", :imageurl => "forum.png", :performancetimes => "April 17 2008, 11PM|April 18 2008, 3PM|April 18 2008, 11PM|April 19 2008, 3PM|April 19 2008, 8PM", :timesvisible => true, :ticketstatus => "completed", :director => "Matt Joachim", :loc => "Rangos Ballroom, UC", :author => "Stephen Sondheim, Burt Shevelove and Larry Gelbart")
shows = shows && Show.create(:name => "Proof", :shortdisplayname => "Proof", :abbrev => "proof", :imageurl => "proof.png", :performancetimes => "Feb 15 2008, 8PM|Feb 16 2008, 3PM|Feb 16 2008, 8PM", :timesvisible => true, :ticketstatus => "completed", :director => "Scott Wasserman", :loc => "Peter/Wright/McKenna, UC", :author => "David Auburn")
shows = shows && Show.create(:name => "The Pillowman", :shortdisplayname => "The Pillowman", :abbrev => "pillowman", :imageurl => "pillowman.png", :performancetimes => "Nov 29 2007, 8PM|Nov 30 2007, 5PM|Nov 30 2007, 10PM", :timesvisible => true, :ticketstatus => "completed", :director => "Lillian DeRitter", :loc => "Rangos Ballroom, UC", :author => "Martin McDonagh")
shows = shows && Show.create(:name => "The Complete Works of William Shakespeare (Abridged)", :shortdisplayname => "CWoWS(A)", :abbrev => "cwowsa", :imageurl => "cwowsa.png", :performancetimes => "Oct 26 2007, 8PM|Oct 27 2007, 4PM|Oct 27 2007, 8PM", :timesvisible => true, :director => "Shaun Swanson and Scott Wasserman", :ticketstatus => "completed", :loc => "McConomy Auditorium, UC", :author => "the Reduced Shakespeare Company")
shows = shows && Show.create(:name => "The Visit", :shortdisplayname => "The Visit", :abbrev => "visit", :loc => "McConomy Auditorium, UC", :imageurl => "tv.png", :author => "Friedrich DŸrrenmatt", :performancetimes => "October 24 2008 9 PM|October 25 2008 3 PM|October 25 2008 8 PM", :ticketstatus => "completed", :director => "Daniel Dewey and Jackie Bernard", :timesvisible => true)
shows = shows && Show.create(:name => "A Bottle of Scotch", :shortdisplayname => "A Bottle of Scotch", :abbrev => "abos", :loc => "Alumni Hall, CFA", :imageurl => "abos.png", :performancetimes => "December 5 2008 9 PM", :ticketstatus => "completed", :timesvisible => true)
shows = shows && Show.create(:name => "A Few Good Men", :shortdisplayname => "A Few Good Men", :abbrev => "afgm", :loc => "Peter/Wright/McKenna, UC", :imageurl => "afgm.png", :author => "Aaron Sorkin", :performancetimes => "February 13 2009 8 PM|February 14 2009 2PM|February 14 2009 8 PM", :ticketstatus => "completed", :director => "Christopher Wheelahan", :timesvisible => true)
shows = shows && Show.create(:name => "Me And My Girl", :shortdisplayname => "Me And My Girl", :abbrev => "mamg", :loc => "Rangos Ballroom, UC", :imageurl => "mamg.png", :author => "L. Arthur Rose, Douglas Furber, and Noel Gay", :performancetimes => "April 16 2009 8 PM|April 17 2009 3 PM|April 17 2009 11 PM", :ticketstatus => "completed", :director => "Alex DiClaudio and Shannon Deep", :timesvisible => true)
shows = shows && Show.create(:name => "Chugging Scotch", :shortdisplayname => "Chugging Scotch", :abbrev => "chug", :loc => "Conan Room, UC", :imageurl => "chug.png", :performancetimes => "May 2 2009 8 PM", :ticketstatus => "completed", :timesvisible => true)
shows = shows && Show.create(:name => "The Mystery of Edwin Drood", :shortdisplayname => "The Mystery of Edwin Drood", :abbrev => "drood", :loc => "McConomy Auditorium, UC", :imageurl => "drood.png", :author => "Rupert Holmes", :performancetimes => "October 30 2009 8 PM|October 31 2009 3 PM|October 31 2009 8 PM", :ticketstatus => "completed", :director => "Scott Wasserman and Tim Sherman", :timesvisible => true)
shows = shows && Show.create(:name => "Betty's Summer Vacation", :shortdisplayname => "Betty's Summer Vacation", :abbrev => "betty", :loc => "McConomy Auditorium, UC", :imageurl => "betty.png", :author => "Christopher Durang", :performancetimes => "December 4 2009 8 PM|December 5 2009 2 PM|December 5 2009 6 PM", :ticketstatus => "completed", :director => "Tim Sherman", :timesvisible => true)
shows = shows && Show.create(:name => "A Bottle of Scotch part two: Back to the Bottle", :shortdisplayname => "A Bottle of Scotch, Part Two", :abbrev => "bttb", :loc => "Alumni Hall, CFA", :imageurl => "bttb.png", :performancetimes => "Nov 22 2009, 8 PM", :ticketstatus => "completed", :timesvisible => true)
shows = shows && Show.create(:name => "Closer", :shortdisplayname => "Closer", :abbrev => "closer", :loc => "Peter/Wright/McKenna, UC", :imageurl => "closer.png", :author => "Patrick Marber", :performancetimes => "February 19 2010, 8PM|February 20 2010, 3PM|February 20 2010, 8PM", :ticketstatus => "completed", :director => "Caity Pitts and Caitlin Cox", :timesvisible => true)
shows = shows && Show.create(:name => "Dirty Rotten Scoundrels", :shortdisplayname => "Dirty Rotten Scoundrels", :abbrev => "drs", :loc => "Rangos Ballroom, UC", :imageurl => "drs.png", :author => "Jeffrey Lane and David Yazbek", :performancetimes => "April 15 2010 8PM|April 16 2010 3PM|April 16 2010 11PM|April 17 2010 3PM|April 17 2010 8PM", :ticketstatus => "closed", :director => "Alex DiClaudio and Will Weiner", :timesvisible => true)
if shows
  puts "   -> #{(Time.now.to_f-time).to_s[0..5]}s"
else
  puts "   error seeding Shows"
end

#fields: string showid, string name, int size, int pricewithid, int pricewoutid
#required: all
puts "-- seeding Tixsections"
time = Time.now.to_f
tixsections = true
tixsections = tixsections && Ticketsection.create(:showid => "mamg", :name => "A", :size => 200, :pricewithid => 5, :pricewoutid => 10)
tixsections = tixsections && Ticketsection.create(:showid => "chug", :name => "A", :size => 75, :pricewithid => 0, :pricewoutid => 0)
tixsections = tixsections && Ticketsection.create(:showid => "drood", :name => "A", :size => 100, :pricewithid => 5, :pricewoutid => 10)
tixsections = tixsections && Ticketsection.create(:showid => "drood", :name => "B", :size => 200, :pricewithid => 3, :pricewoutid => 8)
tixsections = tixsections && Ticketsection.create(:showid => "betty", :name => "A", :size => 300, :pricewithid => 0, :pricewoutid => 0)
tixsections = tixsections && Ticketsection.create(:showid => "bttb", :name => "A", :size => 200, :pricewithid => 10, :pricewoutid => 10)
tixsections = tixsections && Ticketsection.create(:showid => "closer", :name => "A", :size => 90, :pricewithid => 3, :pricewoutid => 5)
if tixsections
  puts "   -> #{(Time.now.to_f-time).to_s[0..5]}s"
else
  puts "   error seeding Ticketsections"
end

puts "-- seeding Contents"
time = Time.now.to_f
contents = true
contents = contents && Content.create(
  :title => "Purpose",
  :anchor => "purpose",
  :publish => true,
  :order => '1',
  :contentpane => "about",
  :contenttype => "content",
  :article => "As one of the nation's oldest student theatre organizations, Carnegie Mellon University's Scotch'n'Soda Theatre is an entirely student-run group dedicated to the development of student-written theatrical works and to educating the campus community on all aspects of theatre. Scotch'n'Soda is an interdisciplinary organization that values a versatile and diverse constituency devoted to creating unique, innovative, and entertaining products. In collaborating on these products, Scotch'n'Soda builds a strong social network both on campus and off, fostering a safe, supportive environment for creative exploration and artistic expression.

Ticket prices are kept low or are free of charge in order to encourage student patronage, and Scotch'n'Soda strives to make its shows accessible to all audience members while simultaneously challenging them to discover exciting new works and revisiting old favorites. Most importantly, from directing to hanging lighting to acting, painting, and even writing, there's a student in every position of every show."
)
contents = contents && Content.create(
  :title => "Getting Involved",
  :anchor => "getinvolved",
  :publish => true,
  :order => '2',
  :contentpane => "about",
  :contenttype => "content",
  :article => "Scotch'n'Soda Theatre has a very broad and diverse membership, pulling students from every college in the university. Though founded by three drama majors, the organization now boasts members pursuing more than 35 majors. Scotch'n'Soda membership is open to all undergraduate and graduate students at Carnegie Mellon University, as well as to any other members of the campus community who pay their Student Activities Fee (included in tuition). There are plenty of ways to get involved:

|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/tech.png!|{padding:10px;}.**Join a Tech Crew!** The majority of our members serve behind the scenes on tech crews. From set design to publicity, lighting operation to costuming, carpentry to sound design, and even more, students take hands-on roles in every aspect of every production. Ever devoted to teaching, Scotch'n'Soda provides on-the-job learning opportunities for students of all skill levels, as well as leadership opportunities for those with experience. Working out of our own scene shop&#8212;the Dungeon&#8212;we strive to make the technical side of our shows approachable, fun, and educational for all involved.|
|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/act.png!|{padding:10px;}.**Act!** Auditions are open to the entire campus community, regardless of theatrical experience, and are held periodically throughout the production year. With at least five shows a season, Scotch'n'Soda produces musicals, straight plays, and even occasionally experimental threatre pieces, so there's something for everyone.|
|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/workshopping.png!|{padding:10px;}.**Workshop!** At the heart of Scotch'n'Soda is an interest in student written pieces, be they musicals, comedies or dramas. The Workshopping Committee meets year-long to help student playwrights refine their scripts for the stage.|
|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/improvise.png!|{padding:10px;}.**Improvise!** Founded in 1996, the **\"No Parking Players\":http://npp.snstheatre.org** is Scotch'n'Soda Theatre's improv troupe.  NPP practices improvised theatre of all kinds, with a focus on the comedic short form. At the core of the NPP experience are the weekly workshops, open to the entire campus community. People of all experience levels are welcome, including those who have never tried improv before. Most workshops are composed of regulars and newcomers side-by-side. The No Parking Players performance group also has regular bi-weekly shows, featuring a mix of improv games, storytelling, and of course a large dose of audience participation.|

In the beginning of the year, you've got tons of options. Meet us at the Activities Fair in September. Come to our Barbecue. Most importantly, come to a general meeting! These are wacky, fun-filled events where the Board fills the rest of the membership in on upcoming auditions, open staff positions, social events, and other juicy tidbits! Later on, watch the website's \"News\":/ area, \"sign up for the mailing list\":mailto://nqr@andrew.cmu.edu, or watch our bboards for the latest information."
)
contents = contents && Content.create(
  :title => "History",
  :anchor => "history",
  :publish => true,
  :order => '3',
  :contentpane => "about",
  :contenttype => "content",
  :article => "Scotch'n'Soda Theatre is one of the nation's oldest student theatre groups, and is one of the oldest and largest student organizations at Carnegie Mellon University. It was originally founded in the fall of 1907 as The White Friars Club, providing a theatrical outlet for the students of the Carnegie Technical Schools. The White Friars Club was to be short-lived however, as student theatre went on hiatus during World War I. It wasn't until 1932 when a student theatre group by the name of the Bacchanalians was formed for the purpose of producing a musical for Carnegie Tech's Spring Carnival. The organization took its current name in 1937 during a vote by the membership and the newly named student-run theatre troupe founded by three drama majors began producing original full-length musicals for Spring Carnival.

In the 1960s, Scotch'n'Soda began expanding its season by producing shows for Homecoming. Not satisfied with only doing musicals, Scotch'n'Soda introduced the campus' first long-form improvisational comedy production in 1988. This was to be the beginning of a 20 year period of remarkable growth and change for the organization. The early 1990s saw the expansion to a three-production season. In 1994 a subsidiary troupe was formed, The No Parking Players, Carnegie Mellon's first short-form improv comedy group. The action-packed 90s closed out with the permanent expansion to a five-production season in 1998.

Today, Scotch'n'Soda proudly produces five to seven shows each diverse season, ranging from full-scale musicals to intimate black box plays, performing in a variety of spaces in the University Center and elsewhere on the Carnegie Mellon campus. With a strongly committed and talented membership spanning all six of Carnegie Mellon's undergraduate colleges and representing over 35 different majors, Scotch'n'Soda is growing still and is well poised to continue providing student-run theatre to the Carnegie Mellon campus community for years to come."
)
contents = contents && Content.create(
  :title => "Board of Directors",
  :anchor => "board",
  :publish => false,
  :order => '4',
  :contentpane => "about",
  :contenttype => "content",
  :article => "Because there is no administrative authority over Scotch'n'Soda, the organization is governed by a board of nine directors, each position elected annually by the general membership. These nine students work to contribute and act as executive producers to each production and hold weekly meetings to discuss all issues related to the organization.

%(upperbold)2009-2010 Board of Directors%

|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/board.png!|{padding:10px;}.President: \"Aaron Gross\":mailto:president@snstheatre.org
Artistic Director: \"Scott Wasserman\":mailto:ad@snstheatre.org
Vice President: \"Todd Snider\":mailto:vice@snstheatre.org
Managing Director: \"Ankur Gupta\":mailto:md@snstheatre.org
Technical Coordinator: \"Daniel Freeman\":mailto:tc@snstheatre.org
Secretary: \"Nick Ryan\":mailto:secretary@snstheatre.org
Publicist: \"Jasmine Friedrich\":mailto:prc@snstheatre.org
General Membership Coordinator: \"Michelle Stewart\":mailto:gmc@snstheatre.org
Rights & Reservations Representative: \"Timothy Sherman\":mailto:rights@snstheatre.org|

%(upperbold)2009-2010 Auxiliary Board%

|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/aux.png!|{padding:10px;}.Director of Development: \"Alex DiClaudio\":mailto:development@snstheatre.org
Workshopping Committee Chair: \"Shannon Deep\":mailto:workshopping@snstheatre.org
No Parking Players Artistic Directors: \"Pat Kane & Timothy Sherman\":mailto:npp@snstheatre.org
Dungeon Mistress: \"Patty Rupinen\":mailto:dm@snstheatre.org
Assistant Dungeon Master: \"Theodore Martin\":mailto:adm@snstheatre.org
Webmaster: \"Spencer Williams\":mailto:webmaster@snstheatre.org|"
)
contents = contents && Content.create(
  :title => "About the Initiative",
  :anchor => "about70ai",
  :publish => true,
  :order => '1',
  :contentpane => "70ai",
  :contenttype => "content",
  :article => "Throughout its past several seasons, Scotch'n'Soda Theatre's budget, solely provided by Carnegie Mellon Student Activities Fees (included in tuition) and ticket sales, has been hard pressed to keep up with the growing needs of the organization. In addition, as more and more student organizations continue to emerge on campus, Scotch'n'Soda faces increased competition for its share of student activities funds.

As a response, Scotch'n'Soda has launched its first ever large scale fund-raising initiative. It is expected that by raising $160,000 to purchase essential equipment over the course of the campaign, Scotch'n'Soda will be able to reduce show budgets by at least 40% by greatly reducing rental costs. With financial support from Scotch'n'Soda alumni and the Pittsburgh and Carnegie Mellon communities, it is our greatest hope that we can become nearly self-sufficient in most areas of our annual budget, thereby ensuring that Scotch'n'Soda can continue to grow and fulfill its mission for years to come."
)
contents = contents && Content.create(
  :title => "Giving to Scotch'n'Soda",
  :anchor => "giving",
  :publish => true,
  :order => '2',
  :contentpane => "70ai",
  :contenttype => "content",
  :article => "Scotch'n'Soda Theatre appreciates any contribution you are willing to make to ensure our future sustainability. The following methods of giving are the simplest and we thank you in advance for your help.

|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/mail.png!|{padding:10px;}.**By Mail:** Make out your check to \"Carnegie Mellon University\" with \"S'n'S 70th Anniversary Initiative\" in the memo field. Mail to: Carnegie Mellon University, PO Box 371525, Pittsburgh Pa 15251-7525.|
|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/online.png!|{padding:10px}.**Online:** Go to \"https://www.cmu.edu/campaign/ways/online.html\":https://www.cmu.edu/campaign/ways/online.html. Select \"New Gift\", enter the amount you'd like to give, select \"Other\" in the Designation field, and write \"S'n'S 70th Anniversary Initiative\" in the Comments. You will then be asked for information regarding your gift and your payment method.|
|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/phone.png!|{padding:10px;}.**By Phone:** Call the Carnegie Mellon University Office Of Annual Giving at 412-268-2021 and indicate that your gift is for Scotch'n'Soda Theatre.|"
)
if contents
  puts "   -> #{(Time.now.to_f-time).to_s[0..5]}s"
else
  puts "   error seeding Contents"
end

puts "-- seeding Updates"
time = Time.now.to_f
updates = true
updates = updates && Update.create(
  :name => "...and we're back!",
  :anchor => "gen-spring2010",
  :expiredate => DateTime.parse("2010-02-14 12:59:00 -0400"),
  :article => "Back to Pittsburgh and back to business, Scotch'n'Soda Theatre is kicking off the new semester at Carnegie Mellon by jumping straight into rehearsals for **Closer**, \"auditions for Dirty Rotten Scoundrels\":http://online.snstheatre.org and plans for \"Celebrity Autobiography\":http://www.celebrityautobiography.com. It's going to be a busy season and we're incredibly excited. Stay tuned for more news!"
)
updates = updates && Update.create(
  :name => "The October Update",
  :anchor => "70ai-oct",
  :expiredate => DateTime.parse("2010-04-14 12:59:00 -0400"),
  :article => "For those of you who don't get to keep up with Scotch'n'Soda in Pittsburgh, the Development Committee has published the latest update for our alumni. Click \"here\":http://dev.snstheatre.org/~jrfriedr/October%20Update.pdf to read up on what we've been doing, ways to help us out and just how much Jared Cohon loves us!",
  :created_at => DateTime.parse("October 1 2009, 00:00 -0400"),
  :updated_at => DateTime.parse("October 1 2009, 00:00 -0400")
)
updates = updates && Update.create(
  :name => "Carnival is in the air",
  :anchor => "carnival-spr2010",
  :expiredate => DateTime.parse("2010-04-14 12:59:00 -0400"),
  :article => "Spring break is almost here, which means that \"Carnival at Carnegie Mellon\":http://www.cmu.edu/alumni/involved/events/carnival/ is approaching with speed! **Dirty Rotten Scoundrels** is cast and staffed and we're working hard to bring an even greater production to Carnival than ever before! Excited? Ticket reservations will be up soon, we promise."
)
if updates
  puts "   -> #{(Time.now.to_f-time).to_s[0..5]}s"
else
  puts "   error seeding Contents"
end

puts "==  Seeding Database: seeded (#{(Time.now.to_f-timeall).to_s[0..5]}s) ========================================"