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
def mkdir_with_force(outdir, force=false)
  if outdir.class != String
    raise "outdir wrong? Exiting ......"
  end

  if ! Dir.exists?(outdir)
    `mkdir -p #{outdir}`
  else
    if force
      `rm -rf #{outdir}`
      `mkdir -p #{outdir}`
    else
      raise "The outdir #{outdir} has already existed!"
    end
  end
end

