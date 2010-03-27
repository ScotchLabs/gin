class AdminController < ApplicationController

  def login
    session[:user_id] = nil
    if request.post?
      if params[:type] == "login"
        puts "DEBUG admin_controller: user '#{params[:lname]}' logging in..."
        user = User.authenticate(params[:lname], params[:lpassword])
        if !user.nil?
          session[:user_id] = user.id
          session[:user_name] = user.name
          puts "DEBUG admin_controller: user '#{session[:user_name]}' exists"
          uri = session[:original_uri]
          session[:original_uri] = nil
          redirect_to(uri || { :action => "index" })
        else
          flash.now[:notice] = "Invalid user/password combination"
        end
      elsif params[:type] == "create"
        u = User.new
        u.name = params[:cname]
        u.email = params[:cemail]
        u.emailConfirmation = params[:cemailConfirmation]
        u.password = params[:cpassword]
        if u.save
          puts "DEBUG admin_controller#login: saved new user '#{u}'"
          Mailer::deliver_account_created_mail(u)
          Mailer::deliver_account_created_admin_mail(u)
          redirect_to({:action => "createaccount"})
        else
          message = "There was a problem with your input:<br />"
          u.errors.each{|attr,msg| message+="#{attr} #{msg}<br />"}
          flash.now[:notice] = message
        end
      elsif params[:type] == "forgot"
        email = params[:femail]
        flash.now[:notice] = "Please enter a valid email address!" if email.nil? or email.blank? or !email.match(/[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/) 
        puts "DEBUG admin_controller#login: forgot, email is '#{email}'"
        u=User.find_by_email(email)
        if u.nil?
          flash.now[:notice] = "We couldn't find a user with that email address"
        else
          flash.now[:notice] = "An email has been sent to #{email} with directions on how to reset your password."
          Mailer::deliver_forgot_mail(u)
        end
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end
  
  def forgot
    u=User.find_by_hashed_password(params[:hashed_password])
    if u.nil?
      render :action => "forgotnone"
    else
      # reset the guy's password and email him
      newpwd = ActiveSupport::SecureRandom.base64(9)
      u.password = newpwd
      u.password_confirmation = u.password
      u.emailConfirmation = u.email
      if u.save
        Mailer::deliver_password_reset_mail(u, newpwd)
      else
        redirect_to :action => "forgoterror"
      end
    end
  end
end
