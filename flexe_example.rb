require_relative 'ruby_example'
require 'securerandom'

def example_1
  fifteen_minutes = 15 * 60

  embed_secret = ENV['LOOKER_EMBED_SECRET']
  company_id = ENV['FLEXE_COMPANY_ID'] || "993"

  random_suffix = SecureRandom.alphanumeric(8)

  url_data = {
      host:               'flexedata.looker.com',
      secret:             embed_secret,
      external_user_id:   "embed-test-#{random_suffix}",
      first_name:         'Embed',
      last_name:          "Test #{random_suffix}",
      permissions:        ['access_data', 'see_looks', 'see_user_dashboards'],
      models:             ['flexe_data'],
      user_attributes:    {"company_id" => company_id},
      # access_filters:     {:fake_model => {:id => 1}},
      session_length:     fifteen_minutes,
      embed_url:          "/embed/dashboards/9",
      force_logout_login: false
  }

  url = LookerEmbedClient::created_signed_embed_url(url_data)
  puts "https://#{url}"
end

example_1
