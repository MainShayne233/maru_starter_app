
def upper_camelcase(str)
  str.split('_').map {|s| s[0].upcase + s[1..-1]}.join('')
end

old_name = File.basename(Dir.getwd)

new_name = ARGV[0]

unless new_name
  puts 'Usage: ruby rename_app.rb <new_name>'; exit
end

puts "Are you sure want to rename this app to: #{new_name}? (y/n): "
reply = STDIN.gets
exit unless reply.include?('y')

def rename_app(dir, new_name, old_name)
  Dir.new(dir).each do |file_name|
    next if ['deps', '_build', 'node_modules', 'rename_app.rb', '..', '.'].include?(file_name)
    if Dir.exists?(file_name)

      rename_app("#{dir}/#{file_name}", new_name, old_name)
    else
      file = File.read "#{dir}/#{file_name}"
      updated_file = file.gsub(upper_camelcase(old_name), upper_camelcase(new_name))
      File.write "#{dir}/#{file_name}", updated_file
    end
    if file_name.include? old_name
      `mv #{dir}/#{file_name} #{dir}/#{file_name.gsub(old_name, new_name)}`
    end
  end
end

rename_app '.', new_name, old_name

`mv ../#{old_name} ../#{new_name}`
