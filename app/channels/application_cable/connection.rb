module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connect
      # reject_unauthorized_connection if cookies[:secret] != '123'
    end
  end
end
