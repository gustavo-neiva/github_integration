module Api
  class BaseController < ApplicationController
    include AuthenticationHelper
  end
end