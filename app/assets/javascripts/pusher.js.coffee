$(document).ready(->
  if $("#chat_layer").size() > 0
    pusher = new Pusher('549a0df8768dd8aa4c88')
    channel_name = $("#chat_layer").attr("history_url")
    channel = pusher.subscribe(channel_name)
    channel.bind('message', (data)->
      $("#chat_layer").prepend("<p>#{data[0]} : #{data[1]}</p>")
    )
    channel.bind("pusher:member_added", (member)->
      $("#user_list_layer").prepend("<li>#{member.info.email}</li>")
      $("#chat_layer").prepend("<p> #{member.info.email} has joined </p>") 
    )
)

