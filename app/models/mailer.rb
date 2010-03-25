class Mailer < ActionMailer::Base
  def rez_mail(rez)
    @rez = Ticketrez.find(rez)
    @show = Show.find_by_abbrev(@rez.showid)
    @items = Rezlineitem.all(:conditions => ["rezid = ?",@rez.id])
    
    recipients    @rez.email
    subject       "Thank you for your reservation with Scotch'n'Soda Theatre!"
    from          "tickets@snstheatre.org"
    content_type  "multipart/alternative"
    
    part :content_type => "text/html",
      :body => render_message("rez.html", :rez => @rez)
    part "text/plain" do |p|
      p.body = render_message("rez.plain", :rez => @rez)
      p.transfer_encoding = "base64"
    end
  end

end
