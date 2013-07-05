##!/bin/sh
#tmp.tcl exec \ tclsh "$0" ${1+"$@"}
set test  "

	 Tab Space
 	Space Tab
	 	Tab Space Tab
		 Tab Tab Space
 		Space Tab Tab
	  Tab Space Space
 	 Space Tab Space
  	Space Space Tab"

set list "s t s t  t  t  "

set space [lsearch  -all $list s ]
set tab [lsearch  -all $list t ]

set whiteline [llength [concat $tab $space]]

set whitelength [llength $list]

if {$whitelength == $whiteline} {
puts yes
} else {puts no }

