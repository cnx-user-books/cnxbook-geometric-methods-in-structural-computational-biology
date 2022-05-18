proc print_rmsd_through_time {{mol top}} {
    # Open custom file for output
    set fp [open "rmsd_output.txt" w]
    # use frame 0 for the reference
    set reference [atomselect $mol "protein" frame 0]
    # the frame being compared
    set compare [atomselect $mol "protein"]

    set num_steps [molinfo $mol get numframes]
    for {set frame 0} {$frame < $num_steps} {incr frame} {
        # get the correct frame
        $compare frame $frame

        # compute the transformation
        set trans_mat [measure fit $compare $reference]
        # do the alignment
        $compare move $trans_mat
        # compute the RMSD
        set rmsd [measure rmsd $compare $reference]
        # print the RMSD
        puts $fp "RMSD of $frame is $rmsd"
     }
     close $fp
} 
