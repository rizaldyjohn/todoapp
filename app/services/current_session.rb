class CurrentSession
  attr_reader :session, :cookies

  def initialize(session, cookies)
    session[:user] ||= { } # Create a session for user if it isn't already present
    cookies.signed[:fixed_id] ||= { value: SecureRandom.hex(16), expires: 24.hours.from_now } # Create a fixed session id

    @session = session
    @cookies = cookies
  end

  # Logging out, destroy session
  def destroy
    session.delete(:user)
  end

  def user
    @user ||= User.find_by(id: session[:user]['id'])
  end

  def user=(user)
    session[:user] = session[:user].merge({ id: user.id })
  end

  def sign_in?
    user.present?
  end

  def fixed_id
    cookies.signed[:fixed_id]
  end
end
