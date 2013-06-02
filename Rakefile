# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
Bundler.require
require 'bubble-wrap/media'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'reader'
  app.identifier = 'org.nolten.reader'
  app.provisioning_profile = "/Users/joachim/Library/MobileDevice/Provisioning Profiles/9C3CA802-FAA5-43C9-99A2-2471EF5BC20E.mobileprovision"

  # Only needed if you have not already specifying a pods dependency
  app.pods do
    pod 'GDataXML-HTML'
    pod 'Audjustable'
  end

end
