module Helpers
  include ActionView::Helpers::RenderingHelper
  include AuthenticationHelper

  def authenticated_header(user)
    token = JsonWebToken.encode(user_id: user.id)
    { 'Authorization': token }
  end
end