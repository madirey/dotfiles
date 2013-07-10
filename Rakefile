require 'date'
require 'rake'

desc "Run once to initially set up the computer to use the dotfiles"
task :setup => [:update] do
    Dir["src/*"].each do |file|
        # full path to file
        source = File.join(Dir.pwd, file)
        # just the file name
        basename = File.basename(file)
        # where we want it to be
        destination = File.expand_path("~/.#{basename}")
        conditionally_symlink(source, destination)
    end
end

desc "Update to the latest and greatest, and run any installs that need to happen"
task :update do
    sh "git pull origin master"
end

def conditionally_symlink(source, destination)
    # if on mac, create a .bash_profile instead of .bashrc
    if RUBY_PLATFORM.downcase.include?('darwin')
        if destination.split('/')[-1] == '.bashrc'
            conditionally_symlink(source, destination.sub('bashrc', 'bash_profile'))
        end
    end

    source = File.expand_path(source)
    destination = File.expand_path(destination)
    if File.exist?(source)
        if File.symlink?(destination)
            symlink_to = File.readlink(destination)
            if symlink_to == source
                puts "  #{destination} already symlinked, nothing to do"
            else
                puts "  relinking #{destination} from #{symlink_to} to #{source}"
                FileUtils.rm(destination)
                FileUtils.ln_s(source, destination)
            end
        elsif File.exist?(destination)
            # tack on today's date in YYYYMMDD
            backup_location = "#{destination}.#{Date.today.strftime("%Y%m%d")}"
            puts "  #{destination} already exists. Backing up to #{backup_location}"
            FileUtils.mv(destination, backup_location)
            FileUtils.ln_s(source, destination)
        else
            puts "  creating symlink for #{destination}"
            FileUtils.ln_s(source, destination)
        end
    else
        puts "  #{destination} doesn't exist, cannot create symlink"
    end
end

# just running `rake` runs `rake setup`
task :default => :setup
