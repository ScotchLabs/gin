# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
User.create(:name => "sewillia", :hashed_password => "33c67c43408c9c33a5e275edcc6842a33df13d21", :salt => "21820796800.810446062090216")
# shows should be accurate as of 12/27/09
Show.create(:name => "The Visit", :abbrev => "visit", :loc => "McConomy, UC", :imageurl => "tv.png", :author => "Friedrich Dürrenmatt", :ticketprices => "", :performancetimes => "October 24 2008 9 PM|October 25 2008 3 PM|October 25 2008 8 PM", :ticketstatus => "completed", :homeshow => "datetime")
Show.create(:name => "A Bottle of Scotch", :abbrev => "abos", :loc => "Alumni Hall, CFA", :imageurl => "abos.png", :author => "", :ticketprices => "", :performancetimes => "December 5 2008 9 PM", :ticketstatus => "completed", :homeshow => "datetime")
Show.create(:name => "A Few Good Men", :abbrev => "afgm", :loc => "Peter Wright McKenna, UC", :imageurl => "afgm.png", :author => "Aaron Sorkin", :ticketprices => "", :performancetimes => "February 13 2009 8 PM|February 14 2009 2PM|February 14 2009 8 PM", :ticketstatus => "completed", :homeshow => "datetime")
Show.create(:name => "Me And My Girl", :abbrev => "mamg", :loc => "Rangos Ballroom, UC", :imageurl => "mamg.png", :author => "L. Arthur Rose, Douglas Furber, and Noel Gay", :ticketprices => "Tickets: $5 with CMU ID, $10 without.", :performancetimes => "April 16 2009 8 PM|April 17 2009 3 PM|April 17 2009 11 PM", :ticketstatus => "completed", :homeshow => "datetime")
Show.create(:name => "Chugging Scotch", :abbrev => "chug", :loc => "Conan Room, UC", :imageurl => "chug.png", :author => "", :ticketprices => "Free to the public", :performancetimes => "May 2 2009 8 PM", :ticketstatus => "completed", :homeshow => "datetime")
Show.create(:name => "The Mystery of Edwin Drood", :abbrev => "drood", :loc => "McConomy, UC", :imageurl => "drood.png", :author => "Rupert Holmes", :ticketprices => "$8 or $10 depending on section<br>$5 off with Student ID", :performancetimes => "October 30 2009 8 PM|October 31 2009 3 PM|October 31 2009 8 PM", :ticketstatus => "completed", :homeshow => "datetime")
Show.create(:name => "Betty's Summer Vacation", :abbrev => "betty", :loc => "McConomy, UC", :imageurl => "betty.png", :author => "Christopher Durang", :ticketprices => "Tickets free to the public", :performancetimes => "December 4 2009 8 PM|December 5 2009 2 PM|December 5 2009 6 PM", :ticketstatus => "completed", :homeshow => "datetime")
Show.create(:name => "A Bottle of Scotch part two: Back to the Bottle", :abbrev => "bttb", :loc => "Alumni Hall, CFA", :imageurl => "bttb.png", :author => "", :ticketprices => "$10", :performancetimes => "Nov 22 2009, 8 PM", :ticketstatus => "completed", :homeshow => "datetime")
Show.create(:name => "Closer", :abbrev => "closer", :loc => "Peter Wright McKenna, UC", :imageurl => "closer.png", :author => "", :ticketprices => "", :performancetimes => "", :ticketstatus => "closed", :homeshow => "none")
Show.create(:name => "Celebrity Autobiography", :abbrev => "cab", :loc => "Rangos Ballroom, UC", :imageurl => "temp.png", :author => "", :ticketprices => "", :performancetimes => "", :ticketstatus => "closed", :homeshow => "none")
Show.create(:name => "Dirty Rotten Scoundrels", :abbrev => "drs", :loc => "Rangos Ballroom, UC", :imageurl => "temp.png", :author => "", :ticketprices => "", :performancetimes => "", :ticketstatus => "closed", :homeshow => "none")
Pane.create(:title => "Ticket Kiosk", :menutitle => "", :anchor => "http://tickets.snstheatre.org/", :publish => true, :hidden => false, :hasmenu => false, :order => 1, :panetype => "pane")
Pane.create(:title => "About Us", :menutitle => "", :anchor => "about", :publish => true, :hidden => false, :hasmenu => false, :order => 2, :panetype => "pane")
Pane.create(:title => "70th Anniversary Initiative", :menutitle => "", :anchor => "70ai", :publish => true, :hidden => false, :hasmenu => false, :order => 3, :panetype => "pane")
Pane.create(:title => "Contact Us", :menutitle => "", :anchor => "contact", :publish => true, :hidden => false, :hasmenu => false, :order => 4, :panetype => "pane")

