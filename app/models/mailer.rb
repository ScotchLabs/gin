class Mailer < ActionMailer::Base
  
  def rez_mail(rez)
    @rez = rez
    @show = Show.find_by_abbrev(rez.showid)
    @items = Rezlineitem.all(:conditions => ["rezid = ?",rez.id])
    
    @from = "tickets@snstheatre.org"
    @recipients = rez.email
    @subject = "Thank you for your reservation with Scotch'n'Soda Theatre!"
  end

end
