set debuginfod enabled on
set disassemble-next-line auto
set history save on
set history remove-duplicates unlimited
set print pretty on
set print array-indexes on
set print object on

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
document threads
Print threads in target.
end
