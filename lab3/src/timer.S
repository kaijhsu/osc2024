#include "arm/sysregs.h"

// LAB3-4
.globl get_cpu_cycles
get_cpu_cycles:
    mrs x0, cntpct_el0
    ret
.globl set_cpu_cycles
set_cpu_cycles:
    msr cntpct_el0, x0
    ret

.globl get_cpu_frequency
get_cpu_frequency:
    mrs x0, cntfrq_el0
    ret
.globl set_timer_expired
set_timer_expired:
    msr cntp_tval_el0, x0
    ret

.globl set_timer_limit
set_timer_limit:
    msr cntp_cval_el0, x0
    ret



.globl set_core_timer
set_core_timer:
    cbz x0, disable_core_timer 
    mov x0, 1
    msr cntp_ctl_el0, x0
    mov x0, 2
    ldr x1, =CORE0_TIMER_IRQ_CTRL
    str w0, [x1] // unmask timer interrupt
    ret
disable_core_timer:
    mov x2, 0
    ldr x1, =CORE0_TIMER_IRQ_CTRL
    str w2, [x1]
    ret
