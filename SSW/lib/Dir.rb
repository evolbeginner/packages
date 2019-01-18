class Dir
    def self.mkdirs(path)
        if(!File.directory?(path))
            if(!mkdirs(File.dirname(path)))
                return false;
            end
            mkdir(path)
        end
        return true
    end
end


################################################################################
def mkdir_with_force(outdir, is_force=false, is_tolerate=false)
  if outdir.class != String
    raise "outdir wrong? Exiting ......"
  end

  if ! Dir.exists?(outdir)
    `mkdir -p #{outdir}`
  else
    if is_tolerate
      ;
    elsif is_force
      `rm -rf #{outdir}`
      `mkdir -p #{outdir}`
    else
      raise "The outdir #{outdir} has already existed!"
    end
  end
end


def read_infiles(indir, suffix='')
  infiles = Array.new
  Dir.foreach(indir) do |b|
    next if b =~ /^\./
    if suffix.is_a?(String)
      next if b !~ /#{suffix}$/ if suffix != ''
    elsif suffix.is_a?(Array)
      next unless suffix.any?{|i| b =~ /#{i}$/ }
    end
    infiles << File.join(indir, b)
  end
  return(infiles)
end


def getFilesBySuffices(indir, suffices)
  files = Array.new
  infiles = read_infiles(indir)
  infiles.each do |infile|
    if suffices.include?(File.extname(infile))
      files << infile
    end
  end
  return(files)
end


