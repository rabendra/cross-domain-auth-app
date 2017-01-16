Koala::Facebook.class_eval do
  def initialize_with_default_settings(*args)
    case args.size
      when 0, 1
        raise "application id and secret are not specified in .env" unless ENV['FACEBOOK_ID'] && ENV['FACEBOOK_SECRET']
        initialize_without_default_settings(ENV['FACEBOOK_ID'].to_s, ENV['FACEBOOK_SECRET'].to_s, args.first)
      when 2, 3
        initialize_without_default_settings(*args)
    end
  end

  alias_method_chain :initialize, :default_settings
end