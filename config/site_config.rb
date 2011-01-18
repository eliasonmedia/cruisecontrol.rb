# site_config.rb contains examples of various configuration options for the local installation
# of CruiseControl.rb.

# YOU MUST RESTART YOUR CRUISE CONTROL SERVER FOR ANY CHANGES MADE HERE TO TAKE EFFECT!!!

# EMAIL NOTIFICATION
# ------------------
# ActionMailer::Base.smtp_settings = {
#    :address =>        "smtp.gmail.com",
#    :port =>           587,
#    :domain =>         "flipstone.com",
#    :authentication => :plain,
#    :user_name =>      "noreply@flipstone.com",
#    :password =>       "NOREPLY_PASSWORD"
# }
# 
# Configuration.email_from = 'development@flipstone.com'
# Configuration.dashboard_url = "http://cruise.flipstone.com/"

# To delete build when there are more than a certain number present, uncomment this line - it will make the dashboard 
# perform better
BuildReaper.number_of_builds_to_keep = 40
# any files that you'd like to override in cruise, keep in ~/.cruise, and copy over when this file is loaded like this
# site_css = CRUISE_DATA_ROOT + "/site.css"
# FileUtils.cp site_css, RAILS_ROOT + "/public/stylesheets/site.css" if File.exists? site_css
