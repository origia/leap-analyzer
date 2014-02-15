class Settings < Settingslogic
  source "#{LeapAnalyzer.root}/config/config.yml"
  namespace LeapAnalyzer.env.to_s
  load!

  local_config = "#{LeapAnalyzer.root}/config/config.local.yml"

  if File.exist?(local_config)
    instance.deep_merge!(Settings.new(local_config))
  end
end
