module Exceptions
  class NotFoundException < RuntimeError
    attr_reader :status, :message
    def initialize
      super
      @message = "Not found"
      @status = 404
    end
  end
end