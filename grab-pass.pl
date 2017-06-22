#!/usr/bin/env perl
use strict;
use warnings;

die "Usage: $0 PASS-REGEX FILENAME\n (use for grepping a pass from -print-before-all output)\n" if not @ARGV;
my $search = $ARGV[0];
my $fh;
if (defined $ARGV[1]) {
    open $fh, "<", $ARGV[1] or die $!;
} else {
    $fh = *STDIN;
}

sub scan_until {
    my ($regex, $should_print) = @_;
    while(my $line = <$fh>) {
        return $line if($line =~ $regex);
        print $line if($should_print);
    }
    return ""
}

until(eof $fh) {
    print scan_until qr/^\*\*\*.*$search.*\*\*\*$/, 0;
    scan_until qr/^\*\*\*(?:(?!$search).)*\*\*\*$/, 1;
}

close($fh);
