module AuthenticationHelper

  def authorize_request
    begin
      find_current_user
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    rescue Exception => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def sign_in(email:, password:)
    user = User.find_by_email(email)
    if user.authenticate(password)
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, username: user.username }, status: :ok
    else
      render json: { error: 'User name or password is incorrect' }, status: :unauthorized
    end
  end

  private

  def find_current_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header)
    User.find(decoded[:user_id])
  end

end