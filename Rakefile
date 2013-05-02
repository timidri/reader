# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require
require 'bubble-wrap/media'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'reader'
  app.identifier = 'org.nolten.reader'
  app.provisioning_profile = "/Users/joachim/All_apps_for_Joachims_iPhone.mobileprovision"

  # Only needed if you have not already specifying a pods dependency
  app.pods do
    pod 'GDataXML-HTML'
    pod 'Audjustable'
  end

end
