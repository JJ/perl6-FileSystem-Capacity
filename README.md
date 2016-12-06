# FileSystem::Capacity
[![Build Status](https://travis-ci.org/ramiroencinas/perl6-FileSystem-Capacity.svg?branch=master)](https://travis-ci.org/ramiroencinas/perl6-FileSystem-Capacity)

Provides filesystem capacity information.

Currently implements filesystem volumes size and free space from:
* GNU/Linux by df command.
* Win32 by wmic command.
* OS X by df command.

## Installing the module ##

    panda update
    panda install FileSystem::Capacity

## Example Usage to get the volumes size and free space with VolumesInfo ##
    use v6;
    use FileSystem::Capacity::VolumesInfo;

    say "Byte version:\n";

    my %vols = volumes-info();

    for %vols.sort(*.key)>>.kv -> ($location, $data) {
      say "Location: $location";
      say "Size: $data<size> bytes";
      say "Used: $data<used> bytes";
      say "Used%: $data<used%>";
      say "Free: $data<free> bytes";
      say "---";
    }

    say "----";

    say "Human version:\n";

    my %vols-human = volumes-info(:human);

    for %vols-human.sort(*.key)>>.kv -> ($location, $data) {
      say "Location: $location";
      say "Size: $data<size>";
      say "Used: $data<used>";
      say "Used%: $data<used%>";
      say "Free: $data<free>";
      say "---";
    }
