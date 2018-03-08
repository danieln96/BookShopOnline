class MessagesController < ApplicationController
   before_action :require_user
   before_action :get_messages
   def create
       message = current_user.messages.build(message_params)
       if message.save
         redirect_to messages_url
       else
         render 'index'
       end
   end
   def index
   
   end
  private

    def get_messages
      @messages = Message.for_display
      @message  = current_user.messages.build
    end

    def message_params
      params.require(:message).permit(:content)
    end
end