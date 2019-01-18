class GFF():
    def __init__(self, line):
        self.chr, self.source, self.feature, self.start, self.end, self.score, self.strand, self.frame, self.attributes = line.split("\t")
        self.start, self.end = map (lambda x: int(x), [self.start, self.end])


######################################################
def replace_by_index(seq_obj, index, new):
    import Bio
    from Bio.Seq import Seq
    from Bio.Alphabet import generic_dna
    lst = []
    for i, j in enumerate(list(seq_obj)):
        if i == index:
            j = new
        else:
            pass
        lst.append(j)
    seq = "".join(lst)
    seq_obj = Seq(seq, generic_dna)
    return(seq_obj)
