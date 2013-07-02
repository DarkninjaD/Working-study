# !/bin/sh
# button_copy.tcl exec tclsh "$0" ${1+"@"}

package require Tk

canvas .c -bg green -width 300 -height 300


#This is just set up.

proc set_up {QUS} {

	.c create text 5 150 -text $QUS -anchor nw
 	button_making .c button_1 yes 100 20
	button_making .c button_2 no 100 70
}

#This is heart of this script, with this proc you just send the data and it makes the button box, text in the      button, tag for the button (us full other muplation) and the small anmation of the button being clicked when the   mouse clicks it.

proc button_making {PATH NAMEB MESSAGE X Y} {
#the button's frame is made here
	$PATH create rect $X $Y [expr {$X + 50 }] [ expr {$Y + 20}] -fill red -tag $NAMEB
#the button's text is made here
	$PATH create text [expr {$X + 50 / 2}] [expr {$Y +20 / 2}] -text $MESSAGE -anchor w -tag $NAMEB
#the small anamtion of the button being clicked is made here
	$PATH bind $NAMEB <1> [list $PATH move $NAMEB 2 2 ]
	$PATH bind $NAMEB <ButtonRelease-1> [list $PATH move $NAMEB -2 -2] 
}

set_up "quation being asked"
# this is just using the "button_1" tag to be a signed to the command "exit". so whem you click on it it profomes the action
.c bind button_1 <ButtonRelease-1> exit 
pack .c
