class UserCreateMailer < ApplicationMailer
  def create(user)
    @user =user
    mail(to: user.email, subject: "Create User")
  end
end
