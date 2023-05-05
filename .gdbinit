set debuginfod enabled on
set disassemble-next-line auto
set history save on
set history remove-duplicates unlimited
set print pretty on
set print array-indexes on
set print object on
set disassembly-flavor intel

define bpl
    info breakpoints
end
document bpl
List all breakpoints.
end

define tuic
    tui
#This is where a layout switch would go
    focus cmd
end
document tuic
Switches to tui and focuses on the command line.
end

define it
    info threads
end
document it
Print threads in target.
end

define rem
    if $argc==0
        target remote localhost:2022
    end
    if $argc==1
        target remote localhost:$arg0
    end
    if $argc==2
        target remote $arg0:$arg1
    end
end
document rem
Connect to gdbserver on localhost:2022 if given no arguments, localhost:arg0 if given 1 argument, arg0:arg1 if given 2 arguments
end
