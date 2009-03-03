#!/usr/bin/env ruby

unless ARGV[0] && ARGV[1]
  puts "This CDN compiler interprets all the tinymce .htm files (typically for plugins), and changes"
  puts "them into javascript files with the correct asset include paths."
  puts ""
  puts "USAGE: ruby cdn-compile.rb local/path/to/jscripts/tiny_mce assethosturl.com/path/to/tiny_mce"
  exit 0;
end

BASE_PATH = ARGV[0]
ASSET_HOST_URL = ARGV[1]
ESCAPED_CHARS = {
  "\010" =>  '\b',
  "\f"   =>  '\f',
  "\n"   =>  '\n',
  "\r"   =>  '\r',
  "\t"   =>  '\t',
  '"'    =>  '\"',
  '\\'   =>  '\\\\',
  '>'    =>  '\u003E',
  '<'    =>  '\u003C',
  '&'    =>  '\u0026'
}
ESCAPE_REGEX = true ? /[\010\f\n\r\t"\\><&]/ : /[\010\f\n\r\t"\\]/

# Stolen from rails 2.2.2
def json_encode(str)
  json = '"' + str.gsub(ESCAPE_REGEX) { |s| ESCAPED_CHARS[s] }
  json.force_encoding('ascii-8bit') if respond_to?(:force_encoding)
  json.gsub(/([\xC0-\xDF][\x80-\xBF]|
           [\xE0-\xEF][\x80-\xBF]{2}|
           [\xF0-\xF7][\x80-\xBF]{3})+/nx) { |s|
    s.unpack("U*").pack("n*").unpack("H*")[0].gsub(/.{4}/, '\\\\u\&')
  } + '"'
end

# Creates the full paths to the relative plugin file paths
def fix_paths(content, file_path, asset_host_path)
  relative_file_path = file_path[BASE_PATH.length..file_path.rindex('/')]
  asset_file_path = "HTTP_OR_S://#{asset_host_path}#{relative_file_path}"
  content.
    gsub(/type="text\/javascript" src="/, "type=\"text/javascript\" src=\"#{asset_file_path}").
    gsub(/href="css\//, "href=\"#{asset_file_path}css/").
    gsub(/ src="img\//, " src=\"#{asset_file_path}img/")
end

# Replaces HTTP_OR_S: with the correct javascript method of doing this, document.location.protocol.
# This assumes the the document has been string-escaped (json-encoded) already.
def fix_domains(content)
  content.gsub(/HTTP_OR_S:/, "\" + document.location.protocol +\"")
end

# Removes the javascripted version of the file, "#{filename}.cdn.js" if it exists.
# Add this to a "clean" call in the future
def remove_processed_file(file_path)
  return unless file_path.match(/\.htm$/)
  
  if File.exist?("#{file_path}.cdn.js")
    File.delete("#{file_path}.cdn.js")
    puts "Deleted #{file_path}.cdn.js"
  end
end

# Outputs the javascripted version of the file to "#{filename}.cdn.js"
def process_file(file_path)
  return unless file_path.match(/\.htm$/)
  
  js_out = "document.open();document.write("
  js_out << fix_domains(json_encode(fix_paths(File.readlines(file_path).join(''), file_path, ASSET_HOST_URL)))
  js_out << ");document.close();"
  File.open("#{file_path}.cdn.js", 'w') { |f| f.write(js_out) }
  puts "Wrote #{file_path}.cdn.js"
end

def process_dir(path)
  Dir.new("#{path}").each do |file|
    next if file.match(/^\.+/)
    file_path = "#{path}/#{file}"
    if FileTest.directory?("#{file_path}")
      process_dir("#{file_path}")
    else
      process_file file_path
    end
  end
end

process_dir(BASE_PATH)
