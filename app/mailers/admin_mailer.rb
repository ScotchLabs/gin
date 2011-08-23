class AdminMailer < ActionMailer::Base
  default :to => User.with_role(:admin).map {|u| "#{u.name} <#{u.email}>"}.join(", "), :from => "webmaster@snstheatre.org"
  
  def account_created(u)
    @user = u
    mail(:subject => "Account created at snstheatre.org")
  end

  def approved(u, r)
    @user = u
    @rez = r
    mail(:subject => "User approved at snstheatre.org")
  end
end
