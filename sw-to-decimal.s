.text
.global _start
_start:
    movia   r2, 0xff200020  # Seven-segment MMIO
    movia   r3, 0xff200040  # Switches MMIO
    movia   r4, NUMS        # base address of digits array
    movi    r7, 10
    break

Loop:
    ldwio    r5, 0(r3)
    mov    r8, r0
    movi    r9, r0

Extract:
    divu    r10, r5, r7
    mul    r11, r10, r7
    sub    r12, r5, r11

    add    r13, r4,r12
    ldb    r14, 0(r13)

    sll    r14, r14, r9
    or    r8, r8, r14

    mov    r5, r10
    addi    r9, r9, 8

    bne    r5, r0, Extract

write_display:
    stwio    r8, 0(r2)
    br Loop


.data
NUMS:
    .byte   0b00111111  # 0
    .byte   0b00000110  # 1
    .byte   0b01011011  # 2
    .byte   0b01001111  # 3
    .byte   0b01100110  # 4
    .byte   0b01101101  # 5
    .byte   0b01111101  # 6
    .byte   0b00000111  # 7
    .byte   0b01111111  # 8
    .byte   0b01100111  # 9
