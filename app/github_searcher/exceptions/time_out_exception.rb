module Exceptions
  class TimeOutException < RuntimeError
    attr_reader :status, :message
    def initialize
      super
      @message = "Request has timed out"
      @status = 408
    end
  end
end