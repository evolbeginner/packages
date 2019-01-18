# SSW bio


#####################################################################################
def read_seq_file(seq_file)
  require 'bio'
  seq_objs = Hash.new
  Bio::FlatFile.open(seq_file).each_entry do |f|
    seq_objs[f.definition] = f
  end
  return seq_objs
end


def read_alns_into_2D_hash(infiles)
  seq_objs = Hash.new{|h,k|h[k]={}}
  infiles.each_with_index do |infile, index|
    bio_in_fh = Bio::FlatFile.open(infile)
    bio_in_fh.each_entry do |f| 
      seq_objs[f.definition][index] = f 
    end 
    bio_in_fh.close
  end 
  return(seq_objs)
end


def read_alns_into_aln_info(infiles)
  aln_info = Hash.new{|h,k|h[k]=[]}
  infiles.each_with_index do |infile, index|
    bio_in_fh = Bio::FlatFile.open(infile)
    bio_in_fh.each_entry do |f| 
      aln_info[index] << f
    end 
    bio_in_fh.close
  end 
  return(aln_info)
end


def get_aln_length(seq_file)
  require 'bio'
  lengths = Array.new
  Bio::FlatFile.open(seq_file).each_entry do |f|
    lengths << f.seq.size
  end

  if lengths.all?{|length|length == lengths[0]}
    return(lengths[0])
  else
    return(false)
  end
end


def getGenomeSize(seq_objs)
  return(seq_objs.values.map{|f|f.length}.reduce(:+))
end


