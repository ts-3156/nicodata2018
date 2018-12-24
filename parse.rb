require 'json'

# Summary:
#   Parse 0000.jsonl to load data into MySQL
#
# Usage:
#   ruby parse.rb 0000.jsonl >0000.csv

keys = %w(video_id title description watch_num comment_num mylist_num category tags upload_time file_type length size_high size_low)

File.foreach(ARGV[0]).with_index do |line, i|
  j = JSON.parse(line)
  line =
    keys.map do |k|
      if k == 'upload_time'
        Time.at(j[k]).strftime('%Y/%m/%d %H:%M:%S')
      elsif k == 'tags'
        '"' + j[k].map{|s| s.gsub('-', '_hp_') }.join('-') + '"'
      else
        j[k].to_s.gsub(',', '_cm_').gsub('"', '_dq_')
      end
    end.join(',')
  puts line
end

