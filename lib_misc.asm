.ZEROPAGE
SOURCEPTR: .byte $00, $00
DESTPTR: .byte $00, $00

.macro LIB_ADDR_STORE_AA S, D
  .scope
  lda #<S
  sta D
  lda #>S
  sta D+1
  .endscope
.endmacro

.macro LIB_POINTER_COPY_AA S, D
  .scope
  lda S
  sta D
  lda S+1
  sta D+1
  .endscope
.endmacro

.macro LIB_COPY_MEM_GT256_AAA SOURCEADDR, DESTADDR, ENDADDR
  .scope
  lda #<SOURCEADDR
  sta SOURCEPTR
  lda #>SOURCEADDR
  sta SOURCEPTR+1
  lda #<DESTADDR
  sta DESTPTR
  lda #>DESTADDR
  sta DESTPTR+1
  ldy #0
  copyloop:
    lda (SOURCEPTR),y
    sta (DESTPTR),y

    iny
    bne copyloop

    inc SOURCEPTR+1
    inc DESTPTR+1
    lda DESTPTR+1
    cmp #>ENDADDR+1
    bne copyloop
  .endscope
.endmacro

.macro LIB_COPY_MEM_AAV SOURCEADDR, DESTADDR, LEN
  .scope
  lda SOURCEADDR
  sta SOURCEPTR
  lda SOURCEADDR+1
  sta SOURCEPTR+1
  lda DESTADDR
  sta DESTPTR
  lda DESTADDR+1
  sta DESTPTR+1
  ldx #LEN
  ldy #0
  copyloop:
    lda (SOURCEPTR),y
    sta (DESTPTR),y

    iny
    dex
    bne copyloop
  .endscope
.endmacro

.macro LIB_POINTER_ADD_256_A ADDRESS_LO
  .scope
  clc
  lda ADDRESS_LO+1
  adc #1
  sta ADDRESS_LO+1
  clc
  .endscope
.endmacro

.macro LIB_POINTER_ADD_AV ADDRESS_LO, VALUE_LO
  .scope
  clc
  lda ADDRESS_LO
  adc #VALUE_LO
  sta ADDRESS_LO
  lda ADDRESS_LO+1
  adc #0
  sta ADDRESS_LO+1
  clc
  .endscope
.endmacro

.macro LIB_POINTER_ADD_AVV ADDRESS_LO, VALUE_LO, VALUE_HI
  .scope
  clc
  lda ADDRESS_LO
  adc #VALUE_LO
  sta ADDRESS_LO
  lda ADDRESS_LO+1
  adc #VALUE_HI
  sta ADDRESS_LO+1
  clc
  .endscope
.endmacro

.macro LIB_UNROLL_LINE_COPY_AA bmp_read_clmn_ptr, bmp_write_clmn_ptr
  .scope
  ldy #0
  clc
;=============================== 0
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 1
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 2
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 3
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 4
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 5
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 6
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 7
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 8
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 9
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 10
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 11
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 12
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 13
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 14
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 15
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 16
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 17
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 18
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 19
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 20
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 21
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 22
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 23
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 24
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 25
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 26
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 27
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 28
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 29
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 30
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 31
  iny ; 0c72
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 32
  ; this is where we cross 256 bytes, and y wraps around
  ; move column pointers forward
  LIB_POINTER_ADD_256_A bmp_read_clmn_ptr ; 0C6F ; 10EA
  LIB_POINTER_ADD_256_A bmp_write_clmn_ptr
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 33
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 34
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 35
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 36
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 37
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 38
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y

;=============================== 39
  iny
  lda (bmp_read_clmn_ptr),y
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  iny
  sta (bmp_write_clmn_ptr),y
  .endscope
.endmacro