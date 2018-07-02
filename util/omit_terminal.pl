#!/usr/bin/env perl

use warnings;
use strict;



my $in  = shift;
my $out = "modify_" . $in;
my $fasta = fasta_parser($in);

open my $fh,">",$out || "can't creat such file:$!";
foreach my $key(keys %$fasta){
	$fasta->{$key} =~ s/(TAA|TAG|TGA)$//;
	print {$fh} ">$key\n";
	print {$fh} wrapper($fasta->{$key}),"\n";
}



sub wrapper{
	my $line = shift();
	my $word = shift() // 60;
	my $pos  = 0;
	while(1){
		$pos += $word;
		last unless $pos < length $line;
		substr $line, $pos, 0, "\n";
		$pos  = (rindex $line,"\n");
		#'\n' was one character, $pos need self-add;
		$pos++;

	} 
	return $line;
}

sub fasta_parser{
        my %fasta;
        my $name;
        my $fl = shift;
        open my $fh,"<","$fl" or die "can't open:$!";
        while(<$fh>){
                s/\r?\n//;
                if(/^>(\S+)/){
                        $name = $1;
                }elsif($name){
                        $fasta{$name} .= $_;
                }
        }
	close $fh;
        return \%fasta;
}