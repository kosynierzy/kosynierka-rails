class HipchatNotification
  def initialize
    @room = 'kosynierzy'
    @username = 'kosynierka.info'
  end

  def send(message, options = {})
    client[room].send(username, message, options)
  end

  private

  attr_reader :room, :username

  def client
    @client ||= HipChat::Client.new(Rails.application.secrets.hipchat_token, api_version: 'v1')
  end
end
