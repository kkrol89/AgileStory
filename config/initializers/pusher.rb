PUSHER_CONFIG_FILE = "#{Rails.root.to_s}/config/credentials/pusher.yml"
Pusher.app_id, Pusher.key, Pusher.secret = if File.exists?(PUSHER_CONFIG_FILE)
    pusher = YAML::load(File.open(PUSHER_CONFIG_FILE))[Rails.env]
    [ pusher['app_id'], pusher['key'], pusher['secret'] ]
  else
    [ ENV['PUSHER_APP_ID'], ENV['PUSHER_KEY'], ENV['PUSHER_SECRET'] ]
  end