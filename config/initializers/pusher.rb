PUSHER_CONFIG = "#{Rails.root.to_s}/config/pusher.yml"
Pusher.app_id, Pusher.key, Pusher.secret = if File.exists?(PUSHER_CONFIG)
    pusher = YAML::load(File.open(PUSHER_CONFIG))
    [ pusher['app_id'], pusher['key'], pusher['secret'] ]
  else
    [ ENV['PUSHER_APP_ID'], ENV['PUSHER_KEY'], ENV['PUSHER_SECRET'] ]
  end