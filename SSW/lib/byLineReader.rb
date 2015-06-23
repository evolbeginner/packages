# read file by line

def byLineReader(filename)
  f = File.open(filename,'r')
  line = f.readline
  while line do
    yield line
    begin
      line = f.readline
    rescue
      break
    end
  end
  f.close
end

