# Prepare symlinks folder. We use symlinks to avoid having Podfile.lock
# referring to absolute paths on developers' machines.

require 'fileutils'
require 'json'

def parse_KV_file(file, separator='=')
  file_abs_path = File.expand_path(file)
  if !File.exist?(file_abs_path)
    return {};
  end
  file_content = File.read(file_abs_path)
  lines = file_content.split("\n")
  result = {}
  lines.each { |line|
    separator_index = line.index(separator)
    if separator_index == nil
      next
    end
    key = line[0..separator_index - 1].strip()
    value = line[separator_index + 1..-1].strip()
    result[key] = value
  }
  return result
end

def flutter_root(f)
  if f
    File.expand_path(File.join(File.dirname(f), '..'))
  else
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
end

def relative_to_f(dir, f)
  Pathname.new(dir).relative_path_from(Pathname.new(File.dirname(f))).to_s
end

def flutter_install_ios_plugin_pods(ios_application_path = nil)
  if ios_application_path != nil
    flutter_application_path = File.expand_path(ios_application_path)
  else
    flutter_application_path = flutter_root(nil)
  end

  # Create a symlinks folder
  symlink_dir = File.expand_path('.symlinks', flutter_application_path)
  FileUtils.mkdir_p(symlink_dir)

  symlink_plugins_dir = File.expand_path('plugins', symlink_dir)
  FileUtils.mkdir_p(symlink_plugins_dir)

  if File.exist?(File.join(flutter_application_path, '.flutter-plugins-dependencies'))
    plugin_pods = JSON.parse(File.read(File.join(flutter_application_path, '.flutter-plugins-dependencies')))
    plugin_pods = plugin_pods['plugins']
    plugin_pods = plugin_pods['ios']

    # Remove stale symlinks
    current_symlinks = FileUtils.cd(symlink_plugins_dir) { Dir.glob('*') }
    plugin_symlinks = plugin_pods.map { |r| r['name'] }
    (current_symlinks - plugin_symlinks).each { |symlink|
      FileUtils.rm_f(File.join(symlink_plugins_dir, symlink))
    }

    # Create new symlinks
    plugin_pods.each do |plugin|
      symlink = File.join(symlink_plugins_dir, plugin['name'])
      FileUtils.rm_f(symlink)
      File.symlink(plugin['path'], symlink)
    end
  end

  symlink_pods_dir = File.expand_path('pods', symlink_dir)
  FileUtils.mkdir_p(symlink_pods_dir)
  FileUtils.cd(symlink_pods_dir) do
    podfile = File.join(symlink_pods_dir, 'Podfile')
    if !File.exist?(podfile)
      File.write(podfile, <<~PODFILE)
        platform :ios, '10.0'

        target 'Pods-Runner' do
          pod 'file_provider', '~> 0.0.1'
          pod 'flutter_google_places', '~> 0.1.5'
          pod 'fluttertoast', '~> 4.0.0'
        end
      PODFILE
    end
  end
end

def flutter_application_path
  File.expand_path(File.join(File.dirname(__FILE__), '..'))
end

flutter_install_ios_plugin_pods(File.join(flutter_application_path, 'ios'))
