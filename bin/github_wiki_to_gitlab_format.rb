#!/usr/bin/ruby

require 'optparse'

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: convert_github_wiki_links_to_gitlab_format.rb"
  opts.on("-i", "--input filepath", "Input file path (required)") do |i|
    options[:input] = i
  end
  opts.on("-o", "--output filepath", "Output file path (required)") do |i|
    options[:output] = i
  end
  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end
end

begin
  optparse.parse!
  mandatory = [:input, :output] # Enforce the presence of
  missing = mandatory.select { |param| options[param].nil? } # the -t and -f switches
  if not missing.empty? #
    puts "Missing options: #{missing.join(', ')}"
    puts optparse
    exit
  end
rescue OptionParser::InvalidOption, OptionParser::MissingArgument
  puts $!.to_s # Friendly output when parsing fails
  puts optparse
  exit
end

temp_file = "#{options[:output]}.tmp"
outfile = File.open(temp_file, 'w')

File.open(options[:input], 'r').each do |input_line|
  link_match = input_line.match(/(?<prelink>.*)\[\[(?<link>.+)\]\](?<postlink>.*)/)
  if (link_match)
    pretty_title = link_match[:link]
    corrected_link = pretty_title.gsub(" ", "-")
    corrected_link = corrected_link.gsub("(", "-")
    corrected_link = corrected_link.gsub(")", "-")
    output_line = "#{link_match[:prelink]}[#{pretty_title}](#{corrected_link})#{link_match[:postlink]}"
    outfile << output_line << "\n"
  else
    outfile << input_line
  end
end

outfile.close
File.rename(temp_file, options[:output])