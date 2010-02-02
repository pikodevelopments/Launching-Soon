require 'dispatcher'

Dispatcher.to_prepare :launching_soon do
  require_dependency 'application_controller'
  ApplicationController.send(:include, LaunchingSoon)
end
