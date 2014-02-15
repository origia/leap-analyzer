class Settings < Settingslogic
  source "#{LeapAnalyzer.root}/config/config.yml"
  namespace LeapAnalyzer.env.to_s
  load!
end
