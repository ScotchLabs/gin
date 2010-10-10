#USERS
ar = [
  ['sewillia','s@spencerenglish.com'],
  ['jrfriedr','jasmine.friedrich@gmail.com'],
  ['dfreeman','dfreeman@andrew.cmu.edu'],
  ['achivett','achivett@andrew.cmu.edu'],
  ['amgross','amgross@andrew.cmu.edu'],
  ['mdickoff','mdickoff@andrew.cmu.edu']
]
for u in ar
  u=User.new(:name => u[0], :email => u[1], :emailConfirmation => u[1])
  u.password = 'iamsosecure'
  u.save!
end
sewillia = User.find_by_name('sewillia')
jrfriedr = User.find_by_name('jrfriedr')
dfreeman = User.find_by_name('dfreeman')
achivett = User.find_by_name('achivett')
amgross = User.find_by_name('amgross')
mdickoff = User.find_by_name('mdickoff')

#ROLES
Role.create(:rname => "Administrator", :rabbrev => "admin", :rcontents => "crud", :rshows => "crud", :rusers => "crud", :rupdates => "crud", :rroles => "crud", :rroleassocs => "crud", :rticketalerts => "crud", :rticketrezs => "crud", :rticketsections => "crud", :rrezlineitems => "crud", :rboxoffice => 'crud')
Role.create(:rname => "Developer", :rabbrev => "dev", :rshows => "crud", :rusers => 'r', :rupdates => "crud", :rroles => "crud", :rroleassocs => "crud", :rticketalerts => "crud", :rticketrezs => "crud", :rticketsections => "crud", :rrezlineitems => "crud", :rboxoffice => '')
Role.create(:rname => "Content writer", :rabbrev => "writer", :rcontents => "crud", :rshows => "crud", :rusers => 'r', :rupdates => "crud", :rticketsections => "crud", :rboxoffice => '')
Role.create(:rname => "Ticketmaster", :rabbrev => "tixer", :rshows => "crud", :rusers => 'r', :rticketalerts => "crud", :rticketrezs => "crud", :rticketsections => "crud", :rrezlineitems => "crud", :rboxoffice => 'r')
admin = Role.find_by_rabbrev('admin')
dev = Role.find_by_rabbrev('dev')
writer = Role.find_by_rabbrev('writer')
tixer = Role.find_by_rabbrev('tixer')

#ROLEASSOCS
Roleassoc.create(:role_id => admin.id, :user_id => sewillia.id)
Roleassoc.create(:role_id => dev.id, :user_id => sewillia.id)
Roleassoc.create(:role_id => dev.id, :user_id => amgross.id)
Roleassoc.create(:role_id => dev.id, :user_id => dfreeman.id)
Roleassoc.create(:role_id => dev.id, :user_id => achivett.id)
Roleassoc.create(:role_id => dev.id, :user_id => mdickoff.id)
Roleassoc.create(:role_id => writer.id, :user_id => jrfriedr.id)
Roleassoc.create(:role_id => writer.id, :user_id => amgross.id)
Roleassoc.create(:role_id => tixer.id, :user_id => jrfriedr.id)
Roleassoc.create(:role_id => tixer.id, :user_id => amgross.id)


#SHOWS
# taken from PMA on 2010-10-10 at 6:29 pm EST
Show.create(:abbrev => 'rocky', :author => 'Richard O\'Brien', :director => 'Nick Petrillo', :housemanemail => 'krivers@andrew.cmu.edu', :housemanname => 'Kelly Rivers', :imageurl => 'rocky.png', :loc => 'McConomy Auditorium', :name => 'The Rocky Horror Show', :performancetimes => 'November 5 2010 23:00|November 6 2010 15:00|November 6 2010 20:00', :seatingmap => '', :shortdisplayname => 'The Rocky Horror Show', :slot => 'Homecoming', :ticketnotes => '', :ticketstatus => 'closed', :timesvisible => true) 
Show.create(:abbrev => 'Footlights', :author => '', :director => '', :housemanemail => 'adiclaud@andrew.cmu.edu', :housemanname => 'Alex DiClaudio', :imageurl => 'footlights.png', :loc => 'McConomy Auditorium', :name => 'Scotch\'n\'Soda Theatre Presents: The Cambridge Footlights', :performancetimes => 'September 18 2010 20:00|September 18 2010 22:30', :seatingmap => '', :shortdisplayname => 'Cambridge Footlights', :slot => 'Other', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'ta', :author => 'Tyler Alderson', :director => 'Tyler Alderson', :housemanemail => '', :housemanname => '', :imageurl => 'sos.png', :loc => 'Connan Room, UC', :name => 'Tyler Alderson\'s Shots of Scotch', :performancetimes => 'April 30 2010 21:00|May 1 2010 15:00|May 1 2010 21:00', :seatingmap => '', :shortdisplayname => 'Shots of Scotch', :slot => 'Festival', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'drs', :author => 'Jeffrey Lane and David Yazbek', :director => 'Alex DiClaudio. Music Directed by Matt Aument. Choreographed by Dan Wetzel', :housemanemail => 'krivers@andrew.cmu.edu', :housemanname => 'Kelly Rivers', :imageurl => 'drs.png', :loc => 'Rangos Ballroom, UC', :name => 'Dirty Rotten Scoundrels', :performancetimes => 'April 15 2010 20:00|April 16 2010 15:00|April 16 2010 23:00|April 17 2010 15:00|April 17 2010 20:00', :seatingmap => '', :shortdisplayname => 'Dirty Rotten Scoundrels', :slot => 'Carnival', :ticketnotes => 'This show is not suitable for children.
A reception will be held following the last performance.', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'closer', :author => 'Patrick Marber', :director => 'Caity Pitts and Caitlin Cox', :housemanemail => '', :housemanname => '', :imageurl => 'closer.png', :loc => 'Peter/Wright/McKenna, UC', :name => 'Closer', :performancetimes => 'February 19 2010, 8PM|February 20 2010, 3PM|February 20 2010, 8PM', :shortdisplayname => 'Closer', :slot => 'Other', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'betty', :author => 'Christopher Durang', :director => 'Tim Sherman', :housemanemail => '', :housemanname => '', :imageurl => 'betty.png', :loc => 'McConomy, UC', :name => 'Betty\'s Summer Vacation', :performancetimes => 'December 4 2009 8 PM|December 5 2009 2 PM|December 5 2009 6 PM', :seatingmap => '', :shortdisplayname => 'Betty\'s Summer Vacation', :slot => 'Other', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'bttb', :author => '', :director => '', :housemanemail => '', :housemanname => '', :imageurl => 'bttb.png', :loc => 'Alumni Hall, CFA', :name => 'A Bottle of Scotch part two: Back to the Bottle', :performancetimes => 'Nov 22 2009, 8 PM', :seatingmap => '', :shortdisplayname => 'A Bottle of Scotch, Part Two', :slot => 'Other', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'drood', :author => 'Rupert Holmes', :director => 'Scott Wasserman and Tim Sherman', :housemanemail => '', :housemanname => '', :imageurl => 'drood.png', :loc => 'McConomy, UC', :name => 'The Mystery of Edwin Drood', :performancetimes => 'October 30 2009 8 PM|October 31 2009 3 PM|October 31 2009 8 PM', :seatingmap => '', :shortdisplayname => 'The Mystery of Edwin Drood', :slot => 'Homecoming', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'chug', :author => '', :director => '', :housemanemail => '', :housemanname => '', :imageurl => 'chug.png', :loc => 'Conan Room, UC', :name => 'Chugging Scotch', :performancetimes => 'May 2 2009 8 PM', :seatingmap => '', :shortdisplayname => 'Chugging Scotch', :slot => 'Festival', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'mamg', :author => 'L. Arthur Rose, Douglas Furber, and Noel Gay', :director => 'Alex DiClaudio and Shannon Deep. Music Directed by Matt Aument. Choreographed by Dan Wetzel', :housemanemail => '', :housemanname => '', :imageurl => 'mamg.png', :loc => 'Rangos Ballroom, UC', :name => 'Me And My Girl', :performancetimes => 'April 16 2009 8 PM|April 17 2009 3 PM|April 17 2009 11 PM', :seatingmap => '', :shortdisplayname => 'Me And My Girl', :slot => 'Carnival', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'afgm', :author => 'Aaron Sorkin', :director => 'Christopher Wheelahan', :housemanemail => '', :housemanname => '', :imageurl => 'afgm.png', :loc => 'Peter/Wright/McKenna, UC', :name => 'A Few Good Men', :performancetimes => 'February 13 2009 8 PM|February 14 2009 2PM|February 14 2009 8 PM', :seatingmap => '', :shortdisplayname => 'A Few Good Men', :slot => 'Other', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'abos', :author => '', :director => '', :housemanemail => '', :housemanname => '', :imageurl => 'abos.png', :loc => 'Alumni Hall, CFA', :name => 'A Bottle of Scotch', :performancetimes => 'December 5 2008 9 PM', :seatingmap => '', :shortdisplayname => 'A Bottle of Scotch', :slot => 'Other', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'visit', :author => 'Friedrich Durrenmatt', :director => 'Daniel Dewey and Jaclyn Bernard', :housemanemail => '', :housemanname => '', :imageurl => 'tv.png', :loc => 'McConomy, UC', :name => 'The Visit', :performancetimes => 'October 24 2008 9 PM|October 25 2008 3 PM|October 25 2008 8 PM', :seatingmap => '', :shortdisplayname => 'The Visit', :slot => 'Homecoming', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'ssu', :author => '', :director => '', :housemanemail => '', :housemanname => '', :imageurl => 'ssu.png', :loc => 'Conan Room, UC', :name => 'Scotch Straight Up', :performancetimes => 'May 2 2008, 9PM|May 3 2008, 9PM', :seatingmap => '', :shortdisplayname => 'Scotch Straight Up', :slot => 'Festival', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'sotrwat', :author => '', :director => '', :housemanemail => '', :housemanname => '', :imageurl => 'sotrwat.png', :loc => 'Conan Room, UC', :name => 'Scotch On The Rocks (With a Twist)', :performancetimes => 'May 2 2008, 7PM|May 3 2008, 7PM', :seatingmap => '', :shortdisplayname => 'Scotch on the Rocks', :slot => 'Festival', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'forum', :author => 'Stephen Sondheim, Burt Shevelove and Larry Gelbart', :director => 'Matt Joachim', :housemanemail => '', :housemanname => '', :imageurl => 'forum.png', :loc => 'Rangos, UC', :name => 'A Funny Thing Happened On The Way To The Forum', :performancetimes => 'April 17 2008, 11PM|April 18 2008, 3PM|April 18 2008, 11PM|April 19 2008, 3PM|April 19 2008, 8PM', :seatingmap => '', :shortdisplayname => '...On The Way To The Forum', :slot => 'Carnival', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'proof', :author => 'David Auburn', :director => 'Scott Wasserman', :housemanemail => '', :housemanname => '', :imageurl => 'proof.png', :loc => 'Peter/Wright/McKenna, UC', :name => 'Proof', :performancetimes => 'Feb 15 2008, 8PM|Feb 16 2008, 3PM|Feb 16 2008, 8PM', :seatingmap => '', :shortdisplayname => 'Proof', :slot => 'Other', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'pillowman', :author => 'Martin McDonagh', :director => 'Lillian DeRitter and Sam Creely', :housemanemail => '', :housemanname => '', :imageurl => 'pillowman.png', :loc => 'Rangos, UC', :name => 'The Pillowman', :performancetimes => 'Nov 29 2007, 8PM|Nov 30 2007, 5PM|Nov 30 2007, 10PM', :seatingmap => '', :shortdisplayname => 'The Pillowman', :slot => 'Other', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true) 
Show.create(:abbrev => 'cwowsa', :author => 'the Reduced Shakespeare Company', :director => 'Shaun Swanson and Scott Wasserman', :housemanemail => '', :housemanname => '', :imageurl => 'cwowsa.png', :loc => 'McConomy, UC', :name => 'The Complete Works of William Shakespeare (Abridged)', :performancetimes => 'Oct 26 2007, 8PM|Oct 27 2007, 4PM|Oct 27 2007, 8PM', :seatingmap => '', :shortdisplayname => 'CWoWS(A)', :slot => 'Homecoming', :ticketnotes => '', :ticketstatus => 'completed', :timesvisible => true)
mamg = Show.find_by_abbrev('mamg')
chug = Show.find_by_abbrev('chug')
drood = Show.find_by_abbrev('drood')
betty = Show.find_by_abbrev('betty')
closer = Show.find_by_abbrev('closer')
bttb = Show.find_by_abbrev('bttb')
closer = Show.find_by_abbrev('closer')
footlights = Show.find_by_abbrev('Footlights')

#TICKETSECTIONS
Ticketsection.create(:show_id => mamg.id, :name => "A", :size => 200, :pricewithid => 5, :pricewoutid => 10)
Ticketsection.create(:show_id => chug.id, :name => "A", :size => 75, :pricewithid => 0, :pricewoutid => 0)
Ticketsection.create(:show_id => drood.id, :name => "A", :size => 100, :pricewithid => 5, :pricewoutid => 10)
Ticketsection.create(:show_id => drood.id, :name => "B", :size => 200, :pricewithid => 3, :pricewoutid => 8)
Ticketsection.create(:show_id => betty.id, :name => "A", :size => 300, :pricewithid => 0, :pricewoutid => 0)
Ticketsection.create(:show_id => bttb.id, :name => "A", :size => 200, :pricewithid => 10, :pricewoutid => 10)
Ticketsection.create(:show_id => closer.id, :name => "A", :size => 90, :pricewithid => 3, :pricewoutid => 5)
Ticketsection.create(:show_id => footlights.id, :name => "1", :size => 150, :pricewithid => 5, :pricewoutid => 10)

#CONTENTS
Content.create(:anchor => 'purpose', :article => "As one of the nation's oldest student theatre organizations, Carnegie Mellon University's Scotch'n'Soda Theatre is an entirely student-run group dedicated to the development of student-written theatrical works and to educating the campus community on all aspects of theatre. Scotch'n'Soda is an interdisciplinary organization that values a versatile and diverse constituency devoted to creating unique, innovative, and entertaining products. In collaborating on these products, Scotch'n'Soda builds a strong social network both on campus and off, fostering a safe, supportive environment for creative exploration and artistic expression.

Ticket prices are kept low or are free of charge in order to encourage student patronage, and Scotch'n'Soda strives to make its shows accessible to all audience members while simultaneously challenging them to discover exciting new works and revisiting old favorites. Most importantly, from directing to hanging lighting to acting, painting, and even writing, there's a student in every position of every show.", :contentpane => "about", :contenttype => "content", :order => 1, :publish => true, :title => "Purpose")
Content.create(:anchor => 'getinvolved', :article => "Scotch'n'Soda Theatre has a very broad and diverse membership, pulling students from every college in the university. Though founded by three drama majors, the organization now boasts members pursuing more than 35 majors. Scotch'n'Soda membership is open to all undergraduate and graduate students at Carnegie Mellon University, as well as to any other members of the campus community who pay their Student Activities Fee (included in tuition). There are plenty of ways to get involved:

|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/tech.png!|{padding:10px;}.**Join a Tech Crew!** The majority of our members serve behind the scenes on tech crews. From set design to publicity, lighting operation to costuming, carpentry to sound design, and even more, students take hands-on roles in every aspect of every production. Ever devoted to teaching, Scotch'n'Soda provides on-the-job learning opportunities for students of all skill levels, as well as leadership opportunities for those with experience. Working out of our own scene shop&#8212;the Dungeon&#8212;we strive to make the technical side of our shows approachable, fun, and educational for all involved.|
|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/act.png!|{padding:10px;}.**Act!** Auditions are open to the entire campus community, regardless of theatrical experience, and are held periodically throughout the production year. With at least five shows a season, Scotch'n'Soda produces musicals, straight plays, and even occasionally experimental threatre pieces, so there's something for everyone.|
|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/workshopping.png!|{padding:10px;}.**Workshop!** At the heart of Scotch'n'Soda is an interest in student written pieces, be they musicals, comedies or dramas. The Workshopping Committee meets year-long to help student playwrights refine their scripts for the stage.|
|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/improvise.png!|{padding:10px;}.**Improvise!** Founded in 1996, the **\"No Parking Players\":http://npp.snstheatre.org** is Scotch'n'Soda Theatre's improv troupe.  NPP practices improvised theatre of all kinds, with a focus on the comedic short form. At the core of the NPP experience are the weekly workshops, open to the entire campus community. People of all experience levels are welcome, including those who have never tried improv before. Most workshops are composed of regulars and newcomers side-by-side. The No Parking Players performance group also has regular bi-weekly shows, featuring a mix of improv games, storytelling, and of course a large dose of audience participation.|

In the beginning of the year, you've got tons of options. Meet us at the Activities Fair in September. Come to our Barbecue. Most importantly, come to a general meeting! These are wacky, fun-filled events where the Board fills the rest of the membership in on upcoming auditions, open staff positions, social events, and other juicy tidbits! Later on, watch the website's \"News\":/ area, \"sign up for the mailing list\":mailto://nqr@andrew.cmu.edu or make an account at our internal site &#8211; \"Scotch on the Web\":http://online.snstheatre.org &#8211; for more information.", :contentpane => "about", :contenttype => "content", :order => 2, :publish => true, :title => "Getting Involved")
Content.create(:anchor => 'history', :article => "Scotch'n'Soda Theatre is one of the nation's oldest student theatre groups, and is one of the oldest and largest student organizations at Carnegie Mellon University. It was originally founded in the fall of 1907 as The White Friars Club, providing a theatrical outlet for the students of the Carnegie Technical Schools. The White Friars Club was to be short-lived however, as student theatre went on hiatus during World War I. It wasn't until 1932 when a student theatre group by the name of the Bacchanalians was formed for the purpose of producing a musical for Carnegie Tech's Spring Carnival. The organization took its current name in 1937 during a vote by the membership and the newly named student-run theatre troupe founded by three drama majors began producing original full-length musicals for Spring Carnival.

In the 1960s, Scotch'n'Soda began expanding its season by producing shows for Homecoming. Not satisfied with only doing musicals, Scotch'n'Soda introduced the campus' first long-form improvisational comedy production in 1988. This was to be the beginning of a 20 year period of remarkable growth and change for the organization. The early 1990s saw the expansion to a three-production season. In 1996 a subsidiary troupe was formed: The No Parking Players, Carnegie Mellon's first short-form improv comedy group. The action-packed 90s closed out with the permanent expansion to a five-production season in 1998.

Today, Scotch'n'Soda proudly produces five to seven shows each diverse season, ranging from full-scale musicals to intimate black box plays, performing in a variety of spaces in the University Center and elsewhere on the Carnegie Mellon campus. With a strongly committed and talented membership spanning all six of Carnegie Mellon's undergraduate colleges and representing over 35 different majors, Scotch'n'Soda is growing still and is well poised to continue providing student-run theatre to the Carnegie Mellon campus community for years to come.", :contentpane => "about", :contenttype => "content", :order => 3, :publish => true, :title => "History")
Content.create(:anchor => 'board', :article => "Because there is no administrative authority over Scotch'n'Soda, the organization is governed by a board of nine directors, each position elected annually by the general membership. These nine students work to contribute and act as executive producers to each production and hold weekly meetings to discuss all issues related to the organization.

%(upperbold)2010&#8211;2011 Board of Directors%

|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/board.png!|President: \"Aaron Gross\":mailto:president@snstheatre.org
Artistic Director: \"Caitlin Cox\":mailto:ad@snstheatre.org
Vice President: \"Daniel Freeman\":mailto:vice@snstheatre.org
Managing Director: \"Kelly Rivers\":mailto:md@snstheatre.org
Technical Coordinator: \"Matt Dickoff\":mailto:tc@snstheatre.org
Secretary: \"Gillian Hassert\":mailto:secretary@snstheatre.org
Public Relations Coordinator: \"Nick Ryan\":mailto:prc@snstheatre.org
General Membership Coordinator: \"Will Weiner\":mailto:gmc@snstheatre.org
Rights & Reservations Representative: \"Jay Rockwell\":mailto:rights@snstheatre.org|

%(upperbold)2009&#8211;2010 Auxiliary Board%

|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/aux.png!|{padding:10px;}.Director of Development: \"Alex DiClaudio\":mailto:development@snstheatre.org
Workshopping Committee Chair: \"Shannon Deep\":mailto:workshopping@snstheatre.org
No Parking Players Artistic Directors: \"Pat Kane & Timothy Sherman\":mailto:npp@snstheatre.org
Dungeon Mistress: \"Patty Rupinen\":mailto:dm@snstheatre.org
Assistant Dungeon Master: \"Theodore Martin\":mailto:adm@snstheatre.org
Webmaster: \"Spencer Williams\":mailto:webmaster@snstheatre.org|", :contentpane => "about", :contenttype => "content", :order => 4, :publish => true, :title => "Board of Directors")
Content.create(:anchor => 'about70ai', :article => "Throughout its past several seasons, Scotch'n'Soda Theatre's budget, solely provided by Carnegie Mellon Student Activities Fees (included in tuition) and ticket sales, has been hard pressed to keep up with the growing needs of the organization. In addition, as more and more student organizations continue to emerge on campus, Scotch'n'Soda faces increased competition for its share of student activities funds.

As a response, Scotch'n'Soda has launched its first ever large scale fund-raising initiative. It is expected that by raising $160,000 to purchase essential equipment over the course of the campaign, Scotch'n'Soda will be able to reduce show budgets by at least 40% by greatly reducing rental costs. With financial support from Scotch'n'Soda alumni and the Pittsburgh and Carnegie Mellon communities, it is our greatest hope that we can become nearly self-sufficient in most areas of our annual budget, thereby ensuring that Scotch'n'Soda can continue to grow and fulfill its mission for years to come.

For more information, please see the updates published by the Development Committee:
\"October 2009\":http://upload.snstheatre.org/gin/updates/October-2009.pdf | \"April 2010\":http://upload.snstheatre.org/gin/updates/April-2010.pdf", :contentpane => "70ai", :contenttype => "content", :order => 1, :publish => true, :title => "About the Initiative")
Content.create(:anchor => 'giving', :article => "Scotch'n'Soda Theatre appreciates any contribution you are willing to make to ensure our future sustainability. The following methods of giving are the simplest and we thank you in advance for your help.

|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/mail.png!|{padding:10px;}.**By Mail:** Make out your check to \"Carnegie Mellon University\" with \"S'n'S 70th Anniversary Initiative\" in the memo field. Mail to: Carnegie Mellon University, PO Box 371525, Pittsburgh Pa 15251-7525.|
|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/online.png!|{padding:10px}.**Online:** Go to \"https://www.cmu.edu/campaign/ways/online.html\":https://www.cmu.edu/campaign/ways/online.html. Select \"New Gift\", enter the amount you'd like to give, select \"Other\" in the Designation field, and write \"S'n'S 70th Anniversary Initiative\" in the Comments. You will then be asked for information regarding your gift and your payment method.|
|{padding:10px;}.!http://upload.snstheatre.org/gin/contents/phone.png!|{padding:10px;}.**By Phone:** Call the Carnegie Mellon University Office Of Annual Giving at 412-268-2021 and indicate that your gift is for Scotch'n'Soda Theatre.|", :contentpane => "70ai", :contenttype => "content", :order => 3, :publish => true, :title => "Giving to Scotch'n'Soda")
Content.create(:anchor => 'progress', :article => "!http://upload.snstheatre.org/gin/contents/capital-bar.png!", :contentpane => "70ai", :contenttype => "content", :order => 2, :publish => false, :title => "Initiative Progress")

Update.create(:anchor => 'rocky', :article => "Our new friends from \"*The Cambridge Footlights*\":http://footlightstour.org have come and gone, seemingly leaving a hole with a British accent in Scotch'n'Soda's collective heart. The show itself was fantastic and we strongly encourage anyone in the northeast to catch a performance before the comedy troupe heads back across the Pond.

But now it's back down to business. \"*Homecoming*\":http://www.cmu.edu/alumni/involved/events/homecoming/schedule.html is coming, and with it, our foray into the bizarre with the cult-classic rock musical, *The Rocky Horror Show*. But don't expect to just sit back and relax - dressing up and audience participation are highly encouraged. Join us on a strange journey that you will never forget!", :created_at => "2010-09-21T10:39:31-04:00", :expiredate => "2010-11-06T23:59:00-04:00", :name => "It's Just A Jump To The Left", :updated_at => "2010-09-21T10:40:21-04:00")
Update.create(:anchor => 'footlights', :article => "This September, Scotch'n'Soda will be hosting **The Cambridge Footlights**, the world-famous comedy troupe who first aired the talents of some of the foremost British comedians and actors of this century; celebrated alumni of the company include Sasha Baron Cohen, Hugh Laurie and John Cleese. The Footlights will be stopping at Carnegie Mellon for one night only on their international tour to perform their acclaimed comedy show &#8220;Good For You&#8221;.

Performances of the show will take place at 8:00p and 10:30p in McConomy Auditorium on September 18th.  Tickets are currently available - click on the event to the left to reserve yours now!", :created_at => "2010-09-06T22:21:04-04:00", :expiredate => "2010-09-18T23:00:00-04:00", :name => "The British Are Coming", :updated_at => "2010-09-13T18:09:02-04:00")
Update.create(:anchor => 'summer-10', :article => "From _The Mystery of Edwin Drood_ to _Shots of Scotch_, we at Scotch'n'Soda Theatre are very pleased with our theatrical season, and we thank you for following us through it! Your support makes long rehearsals and sleepless nights worth all the effort.

Moving into summer, Scotch'n'Soda will taking a much-needed break before we hit the stage again to prepare for \"Carnegie Mellon's Homecoming\":http://www.cmu.edu/alumni/involved/events/homecoming/index.html. Alumni, stay tuned! Freshmen, listen up! You'll be hearing from us regarding opportunities to get involved in the '10&#8211;11 theatrical season.

From everyone at Scotch'n'Soda, have a great summer, and goodnight.", :created_at => "2010-05-02T14:49:09-04:00", :expiredate => "2010-08-23T00:00:00-04:00", :name => "The Curtain Falls on '10", :updated_at => "2010-05-02T14:49:09-04:00")
Update.create(:anchor => '70ai-april-2010', :article => "For those of you who don't get to keep up with Scotch'n'Soda in Pittsburgh, the Development Committee has published the latest update for our alumni. Click \"here\":http://upload.snstheatre.org/gin/updates/April-2010.pdf to read up on what we've been doing, ways to help us out and just how much Jared Cohon loves us!", :created_at => "2010-04-02T08:23:06-04:00", :expiredate => "2010-10-31T00:00:00-04:00", :name => "The April Update", :updated_at => "2010-04-02T08:23:06-04:00")
Update.create(:anchor => 'DRS-tickets', :article => "Tickets are now available for **Dirty Rotten Scoundrels**! Pick yours up at the InfoDesk in the University Center or reserve online at our **\"Ticket Kiosk\":http://tickets.snstheatre.org**.", :created_at => "2010-03-21T16:18:53-04:00", :expiredate => "2010-04-17T00:00:00-04:00", :name => "Tickets Now Available", :updated_at => "2010-03-21T16:19:44-04:00")
Update.create(:anchor => 'gen-spring2010-2', :article => "Spring break is almost here, which means that \"Carnival at Carnegie Mellon\":http://www.cmu.edu/alumni/involved/events/carnival/ is approaching with speed! **Dirty Rotten Scoundrels** is cast and staffed and we're working hard to bring an even greater production to Carnival than ever before! Excited? Ticket reservations will be up soon, we promise.", :created_at => "2010-03-02T12:24:20-05:00", :expiredate => "2010-04-02T08:26:00-04:00", :name => "Carnival is in the air", :updated_at => "2010-04-02T08:24:10-04:00")
Update.create(:anchor => '70ai-oct', :article => "For those of you who don't get to keep up with Scotch'n'Soda in Pittsburgh, the Development Committee has published the latest update for our alumni. Click \"here\":http://upload.snstheatre.org/gin/updates/October-2009.pdf to read up on what we've been doing, ways to help us out and just how much Jared Cohon loves us!
", :created_at => "2009-10-01T00:00:00-04:00", :expiredate => "2010-04-02T08:26:00-04:00", :name => "The October Update", :updated_at => "2010-04-02T08:23:36-04:00")