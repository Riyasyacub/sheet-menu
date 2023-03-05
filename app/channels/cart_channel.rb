class CartChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stop_all_streams
    stream_from "cart_#{params[:cart_id]}"
    puts "*" * 100
    puts "*" * 100
    puts "cart_#{params[:cart_id]}"
    puts "*" * 100
    puts "*" * 100
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
