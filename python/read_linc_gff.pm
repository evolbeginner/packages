
package read_gff_info;



sub read_linc_gff_file{
	my ($gff_file) = @_;
	my %seq_info;
	print "Reading linc gff file\t...........................\n\n";
	open (my $IN, '<', $gff_file) or die "linc gff file cannot be opened";
	while(<$IN>){
		chomp;
		my $chr_num;
		my ($chr,$name,$start,$end, $strand) = split /\t/;
		($chr_num) = $chr =~ /chr(\d+)/;
		$seq_info{$name}{posi} = $start.'-'.$end;
		$seq_info{$name}{pos1} = $start; # pos1 is not posi 
		$seq_info{$name}{pos2} = $end;
		$seq_info{$name}{'chr'}  = 'chr'.$chr_num;
		$seq_info{$name}{strand} = '+' if $strand eq 1;
		$seq_info{$name}{strand} = '-' if $strand eq -1;
	}
	close $IN;
	return (\%linc_info);
}
