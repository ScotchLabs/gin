# create a user in script/console and copy hashed_password and salt to here,
# or use :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871"
# for the password 'bunnies'
User.create(:name => "sewillia", :hashed_password => "f14ca870cf00d6ba27a2f9effbb035b69b642bae", :salt => "21743334400.149901635588873")
User.create(:name => "jrfriedr", :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871")
User.create(:name => "amgross", :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871")
User.create(:name => "dfreeman", :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871")
User.create(:name => "achivett", :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871")
User.create(:name => "mdickoff", :hashed_password => "2f01e0ea7fc7421e669e946d6b16c13e20d32204", :salt => "21743332000.388658344764871")

# need crud[c|r|u|d][contents|shows|users|updates|roles|roleassocs]
Role.create(:name => "Administrator", :abbrev => "admin",
  :crudccontents => true,
  :crudcshows => true,
  :crudcusers => true,
  :crudcupdates => true,
  :crudcroles => true,
  :crudcroleassocs => true,
  :crudrcontents => true,
  :crudrshows => true,
  :crudrusers => true,
  :crudrupdates => true,
  :crudrroles => true,
  :crudrroleassocs => true,
  :cruducontents => true,
  :crudushows => true,
  :cruduusers => true,
  :cruduupdates => true,
  :cruduroles => true,
  :cruduroleassocs => true,
  :cruddcontents => true,
  :cruddshows => true,
  :cruddusers => true,
  :cruddupdates => true,
  :cruddroles => true,
  :cruddroleassocs => true)
Role.create(:name => "Content writer", :abbrev => "writer",
  :crudccontents => true,
  :crudcshows => true,
  :crudcusers => false,
  :crudcupdates => true,
  :crudcroles => false,
  :crudcroleassocs => false,
  :crudrcontents => true,
  :crudrshows => true,
  :crudrusers => false,
  :crudrupdates => true,
  :crudrroles => false,
  :crudrroleassocs => false,
  :cruducontents => true,
  :crudushows => true,
  :cruduusers => false,
  :cruduupdates => true,
  :cruduroles => false,
  :cruduroleassocs => false,
  :cruddcontents => true,
  :cruddshows => true,
  :cruddusers => false,
  :cruddupdates => true,
  :cruddroles => false,
  :cruddroleassocs => false)
Role.create(:name => "Beta tester", :abbrev => "betar",
  :crudccontents => true,
  :crudcshows => true,
  :crudcusers => false,
  :crudcupdates => true,
  :crudcroles => false,
  :crudcroleassocs => false,
  :crudrcontents => true,
  :crudrshows => true,
  :crudrusers => false,
  :crudrupdates => true,
  :crudrroles => false,
  :crudrroleassocs => false,
  :cruducontents => true,
  :crudushows => true,
  :cruduusers => false,
  :cruduupdates => true,
  :cruduroles => false,
  :cruduroleassocs => false,
  :cruddcontents => true,
  :cruddshows => true,
  :cruddusers => false,
  :cruddupdates => true,
  :cruddroles => false,
  :cruddroleassocs => false)

Roleassoc.create(:roleid => "admin", :userid => "sewillia")
Roleassoc.create(:roleid => "writer", :userid => "jrfriedr")
Roleassoc.create(:roleid => "betar", :userid => "jrfriedr")
Roleassoc.create(:roleid => "writer", :userid => "amgross")
Roleassoc.create(:roleid => "betar", :userid => "amgross")
Roleassoc.create(:roleid => "writer", :userid => "dfreeman")
Roleassoc.create(:roleid => "betar", :userid => "dfreeman")
Roleassoc.create(:roleid => "writer", :userid => "achivett")
Roleassoc.create(:roleid => "betar", :userid => "achivett")
Roleassoc.create(:roleid => "writer", :userid => "mdickoff")
Roleassoc.create(:roleid => "betar", :userid => "mdickoff")

# fields: name, abbrev, loc, imageurl, author, ticketprices, performancetimes, ticketstatus, director, timesvisible
# required: name, abbrev, imageurl, ticketstatus, performancetimes, timesvisible
#Show.create(
# :name => "",
# :abbrev => "",
# :imageurl => "",
# :ticketstatus => "",
# :performancetimes => "",
# :timesvisible => 
#)
Show.create(
  :name => "Scotch On The Rocks (With a Twist)",
  :abbrev => "sotrwat",
  :imageurl => "sotrwat.png",
  :performancetimes => "May 2 2008, 7PM|May 3 2008, 7PM",
  :timesvisible => true,
  :ticketstatus => "completed"
)
Show.create(
  :name => "Scotch Straight Up",
  :abbrev => "ssu",
  :imageurl => "ssu.png",
  :performancetimes => "Mat 2 2008, 9PM|May 3 2008, 9PM",
  :timesvisible => true,
  :ticketstatus => "completed"
)
Show.create(
  :name => "A Funny Thing Happened On The Way To The Forum",
  :abbrev => "forum",
  :imageurl => "forum.png",
  :performancetimes => "April 17 2008, 11PM|April 18 2008, 3PM|April 18 2008, 11PM|April 19 2008, 3PM|April 19 2008, 8PM",
  :timesvisible => true,
  :ticketstatus => "completed",
  :director => "Matt Joachim",
  :loc => "Rangos, UC",
  :author => "Stephen Sondheim, Burt Shevelove and Larry Gelbart"
)
Show.create(
  :name => "Proof",
  :abbrev => "proof",
  :imageurl => "proof.png",
  :performancetimes => "Feb 15 2008, 8PM|Feb 16 2008, 3PM|Feb 16 2008, 8PM",
  :timesvisible => true,
  :ticketstatus => "completed",
  :director => "Scott Wasserman",
  :loc => "Peter Wright McKenna, UC"
  :author => "David Auburn"
)
Show.create(
  :name => "The Pillowman",
  :abbrev => "pillowman",
  :imageurl => "pillowman.png",
  :performancetimes => "Nov 29 2007, 8PM|Nov 30 2007, 5PM|Nov 30 2007, 10PM",
  :timesvisible => true,
  :ticketstatus => "completed",
  :director => "Lillian DeRitter",
  :loc => "Rangos, UC",
  :author => "Martin McDonagh"
)
Show.create(
  :name => "The Complete Works of William Shakespeare (Abridged)",
  :abbrev => "cwowsa",
  :imageurl => "cwowsa.png",
  :performancetimes => "Oct 26 2007, 8PM|Oct 27 2007, 4PM|Oct 27 2007, 8PM",
  :timesvisible => true,
  :director => "Shaun Swanson and Scott Wasserman",
  :ticketstatus => "completed",
  :loc => "McConomy, UC",
  :author => "the Reduced Shakespeare Company"
)
Show.create(
  :name => "The Visit",
  :abbrev => "visit",
  :loc => "McConomy, UC",
  :imageurl => "tv.png",
  :author => "Friedrich DŸrrenmatt",
  :performancetimes => "October 24 2008 9 PM|October 25 2008 3 PM|October 25 2008 8 PM",
  :ticketstatus => "completed",
  :director => "Daniel Dewey and Jackie Bernard",
  :timesvisible => true
)
Show.create(
  :name => "A Bottle of Scotch",
  :abbrev => "abos",
  :loc => "Alumni Hall, CFA",
  :imageurl => "abos.png",
  :performancetimes => "December 5 2008 9 PM",
  :ticketstatus => "completed",
  :timesvisible => true
)
Show.create(
  :name => "A Few Good Men",
  :abbrev => "afgm",
  :loc => "Peter Wright McKenna, UC",
  :imageurl => "afgm.png",
  :author => "Aaron Sorkin",
  :performancetimes => "February 13 2009 8 PM|February 14 2009 2PM|February 14 2009 8 PM",
  :ticketstatus => "completed",
  :director => "Christopher Wheelahan",
  :timesvisible => true
)
Show.create(
  :name => "Me And My Girl",
  :abbrev => "mamg",
  :loc => "Rangos Ballroom, UC",
  :imageurl => "mamg.png",
  :author => "L. Arthur Rose, Douglas Furber, and Noel Gay",
  :ticketprices => "Tickets: $5 with CMU ID, $10 without.",
  :performancetimes => "April 16 2009 8 PM|April 17 2009 3 PM|April 17 2009 11 PM",
  :ticketstatus => "completed",
  :director => "Alex DiClaudio and Shannon Deep",
  :timesvisible => true
)
Show.create(
  :name => "Chugging Scotch",
  :abbrev => "chug",
  :loc => "Conan Room, UC",
  :imageurl => "chug.png",
  :ticketprices => "Free to the public",
  :performancetimes => "May 2 2009 8 PM",
  :ticketstatus => "completed",
  :timesvisible => true
)
Show.create(
  :name => "The Mystery of Edwin Drood",
  :abbrev => "drood",
  :loc => "McConomy, UC",
  :imageurl => "drood.png",
  :author => "Rupert Holmes",
  :ticketprices => "$8 or $10 depending on section<br>$5 off with Student ID",
  :performancetimes => "October 30 2009 8 PM|October 31 2009 3 PM|October 31 2009 8 PM",
  :ticketstatus => "completed",
  :director => "Scott Wasserman and Tim Sherman",
  :timesvisible => true
)
Show.create(
  :name => "Betty's Summer Vacation",
  :abbrev => "betty",
  :loc => "McConomy, UC",
  :imageurl => "betty.png",
  :author => "Christopher Durang",
  :ticketprices => "Tickets free to the public",
  :performancetimes => "December 4 2009 8 PM|December 5 2009 2 PM|December 5 2009 6 PM",
  :ticketstatus => "completed",
  :director => "Tim Sherman",
  :timesvisible => true
)
Show.create(
  :name => "A Bottle of Scotch part two: Back to the Bottle",
  :abbrev => "bttb",
  :loc => "Alumni Hall, CFA",
  :imageurl => "bttb.png",
  :ticketprices => "$10",
  :performancetimes => "Nov 22 2009, 8 PM",
  :ticketstatus => "completed",
  :timesvisible => true
)
Show.create(
  :name => "Closer",
  :abbrev => "closer",
  :loc => "Peter Wright McKenna, UC",
  :imageurl => "closer.png",
  :author => "Patrick Marber",
  :performancetimes => "February 19 2010, 8PM|February 20 2010, 3PM|February 20 2010, 8PM",
  :ticketstatus => "closed",
  :director => "Caity Pitts and Caitlin Cox",
  :timesvisible => true
)
Show.create(
  :name => "Dirty Rotten Scoundrels",
  :abbrev => "drs",
  :loc => "Rangos Ballroom, UC",
  :imageurl => "temp.png",
  :author => "Jeffrey Lane and David Yazbek",
  :performancetimes => "February 15 2010|February 16 2010|February 17 2010",
  :ticketstatus => "closed",
  :director => "Alex DiClaudio and Will Weiner",
  :timesvisible => false
)

Content.create(
  :title => "Purpose",
  :anchor => "purpose",
  :publish => true,
  :order => '1',
  :contentpane => "about",
  :contenttype => "content",
  :article => "As one of the nation's oldest student theater organizations, Carnegie Mellon University's Scotch'n'Soda Theatre is an entirely student-run group dedicated to the development of student-written theatrical works and to educating the campus community on all aspects of theatre. Scotch'n'Soda is an interdisciplinary organization that values a versatile and diverse constituency devoted to creating unique, innovative, and entertaining products. In collaborating on these products, Scotch'n'Soda builds a strong social network both on campus and off, fostering a safe, supportive environment for creative exploration and artistic expression.<br />
<br />
Ticket prices are kept low or are free of charge in order to encourage student patronage, and Scotch'n'Soda strives to make its shows accessible to all audience members while simultaneously challenging them to discover exciting new works and revisiting old favorites. Most importantly, from directing to hanging lighting to acting, painting, and even writing, there's a student in every position of every show."
)
Content.create(
  :title => "Getting Involved",
  :anchor => "getinvolved",
  :publish => true,
  :order => '2',
  :contentpane => "about",
  :contenttype => "content",
  :article => "Scotch'n'Soda Theatre has a very broad and diverse membership, pulling students from every college in the university. Though founded by three drama majors, the organization now boasts members pursuing more than 35 majors. Scotch'n'Soda membership is open to all undergraduate and graduate students at Carnegie Mellon University, as well as to any other members of the campus community who pay their Student Activities Fee (included in tuition). There are plenty of ways to get involved:<br /><br />
<table cellpadding='10px' border='0px'>
<tr valign='middle'>
<td>[[i+tech.png]]</td>
<td><b>Join a Tech Crew!</b> The majority of our members serve behind the scenes on tech crews. From set design to publicity, lighting operation to costuming, carpentry to sound design, and even more, students take hands-on roles in every aspect of every production. Ever devoted to teaching, Scotch'n'Soda provides on-the-job learning opportunities for students of all skill levels, as well as leadership opportunities for those with experience. Working out of our own scene shop&#8212;the Dungeon&#8212;we strive to make the technical side of our shows approachable, fun, and educational for all involved.</td>
</tr>
<tr valign='middle'>
<td>[[i+act.png]]</td>
<td><b>Act!</b> Auditions are open to the entire campus community, regardless of theatrical experience, and are held periodically throughout the production year. With at least five shows a season, Scotch'n'Soda produces musicals, straight plays, and even occasionally experimental threatre pieces, so there's something for everyone.</td>
</tr>
<tr valign='middle'>
<td>[[i+improvise.png]]</td>
<td><b>Improvise!</b> Founded in 1996, the <b>[[a+http://npp.snstheatre.org|No Parking Players]]</b> is Scotch'n'Soda Theatre's improv troupe.  NPP practices improvised theatre of all kinds, with a focus on the comedic short form. At the core of the NPP experience are the weekly workshops, open to the entire campus community. People of all experience levels are welcome, including those who have never tried improv before. Most workshops are composed of regulars and newcomers side-by-side. The No Parking Players performance group also has regular bi-weekly shows, featuring a mix of improv games, storytelling, and of course a large dose of audience participation.</td>
</tr>
</table>
In the beginning of the year, you've got tons of options. Meet us at the Activities Fair in September. Come to our Barbecue. Most importantly, come to a general meeting! These are wacky, fun-filled events where the Board fills the rest of the membership in on upcoming auditions, open staff positions, social events, and other juicy tidbits! Later on, watch the website's [[a+http://snstheatre.org/|News]] area, [[m+nqr@andrew.cmu.edu|sign up for the mailing list]], or watch our bboards for the latest information."
)
Content.create(
  :title => "History",
  :anchor => "history",
  :publish => true,
  :order => '3',
  :contentpane => "about",
  :contenttype => "content",
  :article => "Scotch'n'Soda Theatre is one of the nation's oldest student theater groups, and is one of the oldest and largest student organizations at Carnegie Mellon University. It was originally founded in the fall of 1907 as The White Friars Club, providing a theatrical outlet for the students of the Carnegie Technical Schools. The White Friars Club was to be short-lived however, as student theater went on hiatus during World War I. It wasn't until 1932 when a student theater group by the name of the Bacchanalians was formed for the purpose of producing a musical for Carnegie Tech's Spring Carnival. The organization took its current name in 1937 during a vote by the membership and the newly named student-run theater troupe founded by three drama majors began producing original full-length musicals for Spring Carnival.<br />
<br />
In the 1960s, Scotch'n'Soda began expanding its season by producing shows for Homecoming. Not satisfied with only doing musicals, Scotch'n'Soda introduced the campus' first long-form improvisational comedy production in 1988. This was to be the beginning of a 20 year period of remarkable growth and change for the organization. The early 1990s saw the expansion to a three-production season. In 1994 a subsidiary troupe was formed, The No Parking Players, Carnegie Mellon's first short-form improv comedy group. The action-packed 90s closed out with the permanent expansion to a five-production season in 1998.<br />
<br />
Today, Scotch'n'Soda proudly produces five to seven shows each diverse season, ranging from full-scale musicals to intimate black box plays, performing in a variety of spaces in the University Center and elsewhere on the Carnegie Mellon campus. With a strongly committed and talented membership spanning all six of Carnegie Mellon's undergraduate colleges and representing over 35 different majors, Scotch'n'Soda is growing still and is well poised to continue providing student-run theater to the Carnegie Mellon campus community for years to come."
)
Content.create(
  :title => "Board of Directors",
  :anchor => "board",
  :publish => false,
  :order => '4',
  :contentpane => "about",
  :contenttype => "content",
  :article => "Because there is no administrative authority over Scotch'n'Soda, the organization is governed by a board of nine directors, each position elected annually by the general membership. These nine students work to contribute and act as executive producers to each production and hold weekly meetings to discuss all issues related to the organization.<br />
board template goes here"
)
Content.create(
  :title => "About the Initiative",
  :anchor => "about70ai",
  :publish => true,
  :order => '1',
  :contentpane => "70ai",
  :contenttype => "content",
  :article => "Throughout its past several seasons, Scotch'n'Soda Theatre's budget, solely provided by Carnegie Mellon Student Activities Fees (included in tuition) and ticket sales, has been hard pressed to keep up with the growing needs of the organization. In addition, as more and more student organizations continue to emerge on campus, Scotch'n'Soda faces increased competition for its share of student activities funds.<br />
<br />
As a response, Scotch'n'Soda has launched its first ever large scale fund-raising initiative. It is expected that by raising $160,000 to purchase essential equipment over the course of the campaign, Scotch'n'Soda will be able to reduce show budgets by at least 40% by greatly reducing rental costs. With financial support from Scotch'n'Soda alumni and the Pittsburgh and Carnegie Mellon communities, it is our greatest hope that we can become nearly self-sufficient in most areas of our annual budget, thereby ensuring that Scotch'n'Soda can continue to grow and fulfill its mission for years to come."
)
Content.create(
  :title => "Giving to Scotch'n'Soda",
  :anchor => "giving",
  :publish => true,
  :order => '2',
  :contentpane => "70ai",
  :contenttype => "content",
  :article => "Scotch'n'Soda Theatre appreciates any contribution you are willing to make to ensure our future sustainability. The following methods of giving are the simplest and we thank you in advance for your help.<br /><br />
<table cellpadding='10px' border='0px'>
<tr valign='middle'>
<td>[[i+mail.png]]</td>
<td><b>By Mail:</b> Make out your check to \"Carnegie Mellon University\" with \"S'n'S 70th Anniversary Initiative\" in the memo field. Mail to: Carnegie Mellon University, PO Box 371525, Pittsburgh Pa 15251-7525.</td>
</tr>
<tr valign='middle'>
<td>[[i+online.png]]</td>
<td><b>Online:</b> Go to [[a+https://www.cmu.edu/campaign/ways/online.html|https://www.cmu.edu/campaign/ways/online.html]]. Select \"New Gift\", enter the amount you'd like to give, select \"Other\" in the Designation field, and write \"S'n'S 70th Anniversary Initiative\" in the Comments. You will then be asked for information regarding your gift and your payment method.</td>
</tr>
<tr valign='middle'>
<td>[[i+phone.png]]</td>
<td><b>By Phone:</b> Call the Carnegie Mellon University Office Of Annual Giving at 412-268-2021 and indicate that your gift is for Scotch'n'Soda Theatre.</td>
</tr>
</table>"
)
Content.create(
  :title => "Send Us An Email",
  :anchor => "email",
  :publish => false,
  :order => '1',
  :contentpane => "",
  :contenttype => "content",
  :article => "Please use the form below to send us via email comments, questions, or whatever! If you include your email address, we'll do our best to respond quickly.<br /><br />
<form method='post' action='thankyou.php'>
<table width='100%'>
<tr>
<td style=\"width:130px;text-align:right;vertical-align:top\">Name:</td>
<td><input type='text' name='name' id='name' /></td>
</tr>
<tr><td style=\"width:130px;text-align:right;vertical-align:top\">Email Address:</td>
<td><input type='text' name='replyto' id='replyto' /></td>
</tr>
<tr><td style=\"width:130px;text-align:right;vertical-align:top\">Subject:</td>
<td><input type='text' name='subject' id='subject' /></td>
</tr>
<tr>
<td style=\"width:130px;text-align:right;vertical-align:top\">Message:</td>
<td><textarea rows='4' cols='50' name='message' id='message'></textarea></td>
</tr>
<tr>
<td></td>
<td><input type='submit' name='emailBtn' value='Submit' onclick='return validateForm();' /></td>
</tr>
</table>
</form>"
)
Content.create(
  :title => "Follow Us!",
  :anchor => "follow",
  :publish => true,
  :order => '2',
  :contentpane => "contact",
  :contenttype => "content",
  :article => "If you're interested in hearing from Scotch'n'Soda on a more regular basis about opportunities to get involved, performances, or just what we're excited about recently, our Twitter and Facebook pages are the perfect places to go.<br /><br />
<table cellpadding='6px'>
<tr>
 <td>[[i+fb.ico]]</td>
 <td><b>[[a+http://www.facebook.com/home.php#/pages/ScotchnSoda-Theatre/27084790350?ref=ts|The Scotch'n'Soda Facebook Page]]</b> - Become a fan to hear about auditions, tech opportunities and show openings!</td>
</tr>
<tr>
 <td>[[i+twit.ico]]</td>
<td><b>[[a+http://twitter.com/snstheatre|The Scotch'n'Soda Twitter Feed]]</b> - Follow us to keep up to date on our productions and organizational happenings!</td>
</tr></table>"
)
