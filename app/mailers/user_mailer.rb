class UserMailer < ActionMailer::Base
  default :from => "webmaster@snstheatre.org", :reply_to => "webmaster@snstheatre.org"
  
  def rez(rez)
    @rez = rez
    @show = @rez.show
    @items = @rez.rezlineitems
    
    mail(:from => "webmaster@snstheatre.org", :to => "#{@rez.name} <#{@rez.email}>", :subject => "Thank you for your reservation with Scotch'n'Soda Theatre!")
  end
  
  def forgot(u)
    @user = u
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "Password reset request from snstheatre.org")
  end
    
  def account_created(u)
    mail(:to => u.email, :subject => "Account created at snstheatre.org")
  end
  
  def approved(u, r)
    @rez = r    
    mail(:to => u.email, :subject => "snstheatre account approved")
  end
  
  def password_reset(u, pwd)
    @pwd = pwd
    mail(:to => u.email, :subject => "Password reset at snstheatre.org")
  end
end
