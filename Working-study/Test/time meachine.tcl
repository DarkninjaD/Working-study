#!/bin/sh
# time meachine.tcl \
exec tclsh "$0" ${1+"$@"}
#! /usr/bin/env tclsh
 
set auto_path [linsert $auto_path 0 /path/to/tclx/lib]
package require Tclx
 
proc errcleanup {} {
         global backup_path thisdest
         global pidfile
         file delete -force $pidfile
         file delete -force [file join $backup_path $thisdest] 
 }
 
proc sigtrap {signame} {
         if {$signame ni [list SIGCHLD]} {
                 errcleanup
                 error "got some sort of signal: $signame"
         }
 }
 
proc main {} {
         global backup_path thisdest
         global pidfile
         global running
 
         ### configuration ###
 
         set BACKUP_DIRPATH {"/path/to/backup/storage"}
         set BACKUP_DIR backups_rsync
         set DOCUMENTS_SRC_PATH {"/path/to/source"}  
         set DOCUMENTS_DEST_DIR {"/name/of/destinatin_directory/in/$BACKUP_DIRPATH"}
 
         ### end configuration ###
 
         ### initialization ###
         set backup_path [file join $BACKUP_DIRPATH $BACKUP_DIR]
         set now [clock format [clock seconds] -format {%Y-%m-%d-%H-%M-%S}]
         set thisdest $DOCUMENTS_DEST_DIR-$now
         ### end initialization ###
 
         set configdir [file normalize [file join ~ .[file tail [info script]].d]]
         file mkdir $configdir
         set pidfile [file join $configdir pid]
         if {[file exists $pidfile]} {
                 set running 1
                 error "am I already running under pid [exec cat $pidfile]" 
         } else {
                 set chan [open $pidfile w]
                 puts $chan [pid]
                 close $chan
         }
 
         if {![file exists $backup_path]} {
                 error "backup path doesn't exist: $backup_path"
         } 
 
 
 
         #warning: big assumption here about sort order
         #make sure the code adheres to this assumption!
         set dests [glob -nocomplain -directory $backup_path $DOCUMENTS_DEST_DIR*]
         set dests [lsort $dests]
         set lastdest [lindex $dests end]
 
 
 
         set tty yes
         set progress --progress
         if {[catch {fconfigure stdin -mode}]} {
                 set tty no
                 set progress {}
         }
 
 
         set rsync_options [list -a -h $progress]
         if {$lastdest ne {}} {
                 lappend rsync_options --link-dest=$lastdest
         }
 
         set cmd_dry [list exec rsync {*}$rsync_options -n -i $DOCUMENTS_SRC_PATH/ \
                 [file join $backup_path $thisdest] 2>@stderr]
         set cmd [list exec rsync {*}$rsync_options $DOCUMENTS_SRC_PATH/ \
                 [file join $backup_path $thisdest] >@stdout 2>@stderr]
 
         set answer yes
         if {$tty} {
                 puts "the command is:  $cmd"
                 puts "do you want to run the command now?"
                 gets stdin answer 
         }
 
 
 
         if {$answer} {
                 set dryout [{*}$cmd_dry]
                 if {$dryout ne {}} {
                         {*}$cmd
                 }
         } else {
                 puts "command canceled by user"
         } 
 }
 
 signal trap * {sigtrap %S}
 set running 0
 set status [catch {main} result options]
 if {$status} {
         errcleanup
}
if {!$running} {
         file delete -force $pidfile
}
return -options $options $result