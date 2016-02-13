require 'io/console'
require 'rake'

# Many thanks to Tristan at github.com/trishume for this file.

task :default => 'install'

task :install do
  home = ENV["HOME"]
  dootfiles = Dir.pwd()
  linkables = Dir.glob("**/*.link")

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split("/").last.split(".link").last
    target = "#{ home }/.#{ file }"

    if File.symlink?(target)
      # Overwrite existing symlinks from previous dootfile installs
      overwrite = true
    elsif File.exists?(target) 
      next if skip_all
      unless overwrite_all || backup_all
        puts "File already exists: #{ target }."
        puts "  [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.getch
        when 's' then next
        when 'S' then skip_all = true
        when 'o' then overwrite = true
        when 'O' then overwrite_all = true
        when 'b' then backup = true
        when 'B' then backup_all = true
        else
          puts "Invalid input - skipping"
          next
        end
      end
    end

    puts "Linking #{ file }"

    FileUtils.mv(target, "#{ target }.backup") if backup || backup_all
    FileUtils.rm(target) if overwrite || overwrite_all
    FileUtils.symlink("#{ dootfiles }/#{ linkable }", target)
  end

  # Write the dootfile location
  File.open("#{ home }/.dootfiles", 'w') { |f| f.write(dootfiles) }
end

task :uninstall do
  home = ENV["HOME"]
  linkables = Dir.glob("**/*.link")

  linkables.each do |linkable|

    file = linkable.split("/").last.split(".link").last
    target = "#{ home }/.#{ file }"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end

    # Replace any backups made during installation
    if File.exists?("#{ target }.backup")
      FileUtils.mv("#{ target }.backup", target)
    end
  end

  FileUtils.rm_f("#{ home }/.dootfiles")
end
