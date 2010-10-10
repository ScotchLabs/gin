class Mailer < ActionMailer::Base
 
  def rez_mail(rez)
    @rez = Ticketrez.find(rez)
    @show = @rez.show
    @items = @rez.rezlineitems
    
    recipients    @rez.email
    subject       "Thank you for your reservation with Scotch'n'Soda Theatre!"
    from          "tickets@snstheatre.org"
    headers       'return-path' => "webmaster@snstheatre.org"
    content_type  "multipart/alternative"
    
    part :content_type => "text/plain", :body => render_message("rez.text.plain", :rez => @rez)
    part :content_type => "text/html", :body => render_message("rez.text.html", :rez => @rez)
  end
  
  def forgot_mail(u)
    recipients    u.email
    subject       "Password reset request from snstheatre.org"
    from          "webmaster@snstheatre.org"
    content_type  "multipart/alternative"
    
    part :content_type => "text/plain", :body => render_message("forgot.text.plain", :u => u)
    part :content_type => "text/html", :body => render_message("forgot.text.html", :u => u)
  end
    
  def account_created_mail(u)
    recipients    u.email
    subject       "Account created at snstheatre.org"
    from          "webmaster@snstheatre.org"
    content_type  "multipart/alternative"
    
    part :content_type => "text/plain", :body => render_message("create.text.plain", :u => u)
    part :content_type => "text/html", :body => render_message("create.text.html", :u => u)
  end
  
  def account_created_admin_mail(u)
    adminRole = Role.find_by_rabbrev('admin')
    recipients    adminRole.users.map {|u| u.email}
    subject       "Account created at snstheatre.org"
    from          "webmaster@snstheatre.org"
    content_type  "multipart/alternative"
    
    part :content_type => "text/plain", :body => render_message("create_admin.text.plain", :u => u)
    part :content_type => "text/html", :body => render_message("create_admin.text.html", :u => u)
  end
  
  def approved_mail(u, r)
    recipients    u.email
    subject       "snstheatre account approved"
    from          "webmaster@snstheatre.org"
    content_type  "multipart/alternative"
    
    part :content_type => "text/plain", :body => render_message("approved.text.plain", :u => u, :r => r)
    part :content_type => "text/html", :body => render_message("approved.text.html", :u => u, :r => r)
  end
  
  def approved_admin_mail(u, r)
    adminRole = Role.find_by_rabbrev('admin')
    recipients    adminRole.users.map {|u| u.email}
    subject       "User approved at snstheatre.org"
    from          "webmaster@snstheatre.org"
    content_type  "text/plain"
    body          render_message("approved_admin.text.plain", :u => u, :r => r)
  end
  
  def password_reset_mail(u, pwd)
    recipients    u.email
    subject       "Password reset at snstheatre.org"
    from          "webmaster@snstheatre.org"
    content_type  "multipart/alternative"
    
    part :content_type => "text/plain", :body => render_message("reset.text.plain", :u => u, :pwd => pwd)
    part :content_type => "text/html", :body => render_message("reset.text.html", :u => u, :pwd => pwd)
  end
end
