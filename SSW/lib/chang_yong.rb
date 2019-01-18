#! /bin/env ruby


def read_list(infile=nil, field=1, sep="\t")
  genes = Hash.new
  return(genes) if infile.nil?
  in_fh = infile == '-' ? STDIN : File.open(infile, 'r')
  in_fh.each_line do |line|
    line.chomp!
    line_arr = line.split(sep)
    item = line_arr[field-1]
    genes[item] = ''
  end
  in_fh.close if infile != '-'
  return(genes)
end


def reformat_wrapped(s, width=78, num_of_space=0)
  # https://www.safaribooksonline.com/library/view/ruby-cookbook/0596523696/ch01s15.html
  lines = []
  line = ""
  s.split(/\s+/).each do |word|
    if line.size + word.size >= width
      lines << line
      line = word
    elsif line.empty?
       line = word
      else
       line << " " << word
     end
  end
  lines << line if line

  lines.each_with_index do |line, index|
    break if num_of_space == 0
    next if index == 0
    lines[index] = ' ' * num_of_space + line
  end

  return lines.join "\n"
end


def processbar(count, total)
  maxlen = 80
  prop = (count.to_f/total)*100
  jing = '#' * (prop*maxlen/100)
  printf "\r%-80s%s", jing, prop.to_s+'%'
end


def getCorename(infile, is_strict=false)
  b = File.basename(infile)
  if not is_strict
    if b =~ /\./
      b =~ /(.+)\..+$/
    else
      b =~ /^(.+)$/
    end
  else
    b =~ /^([^.]+)/
  end
  c = $1
  return(c)
end


