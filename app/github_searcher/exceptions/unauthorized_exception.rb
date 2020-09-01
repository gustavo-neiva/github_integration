module Exceptions
  class UnauthorizedException < RuntimeError
    attr_reader :status, :message
    def initialize
      super
      @message = "Not authorized"
      @status = 401
    end
  end
end