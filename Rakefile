require 'rake'

# Many thanks to Tristan at github.com/trishume for this file.

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
        puts "Linking #{ file }"

        if File.exists?(target) || File.symlink?(target)
            next if skip_all
            unless overwrite_all || backup_all
                puts "File already exists: #{ target }."
                puts "  [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
                case STDIN.gets.chomp
                when 's' then next
                when 'S' then skip_all = true
                when 'o' then overwrite = true
                when 'O' then overwrite_all = true
                when 'b' then backup = true
                when 'B' then backup_all = true
                else puts "Invalid input - skipping"
                end
            end
        end

        FileUtils.mv(target, "#{ target }.backup") if backup || backup_all
        FileUtils.rm(target) if overwrite || overwrite_all
        FileUtils.symlink("#{ dootfiles }/#{ linkable }", target)
    end

    # Write the dootfile location
    File.open("#{ home }/.dootfiles", 'w') { |f| f.write(dootfiles) }
end

#
# task :uninstall do
#
#   Dir.glob('**/*.symlink').each do |linkable|
#
#     file = linkable.split('/').last.split('.symlink').last
#     target = "#{ENV["HOME"]}/.#{file}"
#
#     # Remove all symlinks created during installation
#     if File.symlink?(target)
#       FileUtils.rm(target)
#     end
#
#     # Replace any backups made during installation
#     if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
#       `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"`
#     end
#
#   end
# end
#
# task :default => 'install'
