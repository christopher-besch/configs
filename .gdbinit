# remove license ridiculousness; be like LLDB :>
shell clear
# remove a few more insanities
set pagination off
set confirm off

# store history in .gdb_history in cwd
set history save on
# we all like pretty things, don't we?
set print pretty on
# memory go brrrrr
set record full insn-number-max unlimited

# has to be set to correct include dir
skip -gfi /usr/include/*
