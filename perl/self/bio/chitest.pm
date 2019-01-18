#! perl/bin/perl-w

package chitest;
use 5.010;
use Statistics::R;
use strict;
require Exporter;

sub chitest{
	my ($a_aref, $b_aref, $return_opts_aref) = @_;
	my (%return, $return);
	my ($R_cmd, $a, $b);
	$a = join (',', @$a_aref);
	$b = join (',', @$b_aref);
	my $R = Statistics::R->new();
	$R_cmd = 'x=data.frame(c(' . $a . '),' . 'c(' . $b . '))';
	$R->startR;
	$R->send(qq'$R_cmd \n chisq.test(x,correct=TRUE)'); 
	#$R->send(qq`x=c(1,2,3,4,6) \n y=mean(x) \n z=$a+y \n print(z)`) ;  
	my $ret = $R->read;
	$R->stopR();
	($return{'X_squared'}) = $ret =~ /X-squared \= ([^\,]+)/;
	($return{'p_value'}) = $ret =~ /p\-value \= (.+)/;
	$return{'all'} = $ret;
	#$ret=~s/\[\d\]\s+(\d+)/$1/g;
	foreach(@$return_opts_aref){
		$return .= $return{$_} if $return{$_};
	}
	$return=$return{'p_value'} if not $return;
	return ($return);
}




