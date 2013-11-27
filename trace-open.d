/*
 * Trace filenames used in calls to open(2).  Run via:
 *
 *      dtrace -s trace-open.d -c 'cmd ...'
 *
 * A less-detailed version of what I'm used to on Linux:
 *
 *      strace -e 'trace=open' cmd ...
 */
syscall::open:entry
/pid == $target/
{
    self->file = arg0;
}

syscall::open:return
/pid == $target/
{
    trace(copyinstr(self->file));
    self->file = 0;
}
