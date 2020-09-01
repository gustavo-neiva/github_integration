module AuthenticationHelper

  def authorize_request
    begin
      find_current_user
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    rescue Exception => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def sign_in(email:, password:)
    user = User.find_by_email(email)
    raise_user_not_found unless user
    if user.authenticate(password)
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, username: user.username }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def find_current_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header)
    User.find(decoded[:user_id])
  end

  def raise_user_not_found
    raise ActiveRecord::RecordNotFound
  end

end