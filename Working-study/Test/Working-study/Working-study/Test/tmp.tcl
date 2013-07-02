##!/bin/sh
#tmp.tcl exec \ tclsh "$0" ${1+"$@"}
puts  "
	 Tab Space
 	Space Tab
	 	Tab Space Tab
		 Tab Tab Space
 		Space Tab Tab
	  Tab Space Space
 	 Space Tab Space
  	Space Space Tab"
set testl "t t t t s s s s"

puts [llength [lsearch -all $testl t]]

