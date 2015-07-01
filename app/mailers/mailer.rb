class Mailer < ActionMailer::Base
  default from: 'contacto@manzanaranaja.com'

  def contact
    @greeting = "Hi"

    mail to: 'danielpunk4@gmail.com', subject: 'Mensaje desde la web'
  end
end
