;
; hardware and io access similar to Amstrad CPC464
; http://www.cpcwiki.eu/index.php/CRTC#Timings_and_relating_with_Z80_instructions_count 
; CE is on  A14 = 0xBx
; /WR is on  A9
; RS  is on  A8
MC8645_BASE      = 0x48
MC8645_WR_SEL    = 0xBC00|MC8645_BASE
MC8645_WR_DATA   = 0xBD00|MC8645_BASE

        ld      hl,#MON_15K_50HZ
        ld      de,#0x1000              ;R0...R15, stating with R0
        ld      bc,#MC8645_WR_SEL
        
write_register:
        out     (c),e
        ld      a,(hl)
        inc     b
        outi
        inc     e
        dec     d
        jr      nz,write_register
        ret
;
; Amstrad CPC timings for TV Monitor 50Hz
;
MON_15K_50HZ:
        .db 63          ; R0 total width
        .db 40          ; R1 visible width
        .db 46          ; R2 hsync pos
        .db 128+14      ; R3 vsync hsync length
        .db 38          ; R4 total height
        .db 0           ; R5 height correction
        .db 25          ; R6 vertical displayed
        .db 30          ; R7 start vsync
        .db 0           ; R8 00 no interlace
        .db 7           ; R9 lines per character
        .db 0           ; R10 cursor start
        .db 0           ; R11 cursor end
        .db 0           ; R12 display start high byte
        .db 0           ; R13 display start low byte
        .db 0           ; R14 cursor address high byte
        .db 0           ; R15 cursor address low byte
