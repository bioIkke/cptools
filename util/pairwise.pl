#!/usr/bin/env perl

use strict;
use warnings;

my $fasta = fasta_parser(shift());

foreach my $key1(keys %$fasta){
	foreach my $key2 (keys %$fasta){
		next if $key1 eq $key2;
		open my $fh,">", $key1 . "_" . $key2 . ".fas" || die "can't create:";
		print $fh ">$key1\n", $fasta->{$key1}, "\n";
		print $fh ">$key2\n", $fasta->{$key2}, "\n";
		close $fh;
	}
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