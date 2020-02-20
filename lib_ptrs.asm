.ZEROPAGE
DEST_BITMAP = $A000
DEST_COLOR  = $8C00
bmp_read_row_ptr: .byte $00,$00
bmp_write_row_ptr: .byte $00,$00
bmp_read_clmn_ptr: .byte $00,$00
bmp_write_clmn_ptr: .byte $00,$00

clr_read_row_ptr: .byte $00,$00
clr_write_row_ptr: .byte $00,$00
TEMPPTR: .byte $00, $00
TEMPREG: .byte $00

.segment "SUBROUTINES"
LIB_MOVE_BMP_POINTERS_BY_Y:
  sty TEMPREG
  LIB_ADDR_STORE_AA org_bitmap, TEMPPTR
  inc_read_bmp_loop:
  LIB_POINTER_ADD_AVV TEMPPTR, <320, >320
  dey
  bne inc_read_bmp_loop
  LIB_POINTER_COPY_AA TEMPPTR, bmp_read_row_ptr
  LIB_POINTER_COPY_AA TEMPPTR, bmp_read_clmn_ptr

  LIB_ADDR_STORE_AA DEST_BITMAP, TEMPPTR
  ldy TEMPREG
  inc_write_bmp_loop:
  LIB_POINTER_ADD_AVV TEMPPTR, <320, >320
  dey
  bne inc_write_bmp_loop
  LIB_POINTER_COPY_AA TEMPPTR, bmp_write_row_ptr
  LIB_POINTER_COPY_AA TEMPPTR, bmp_write_clmn_ptr
  rts

LIB_MOVE_CLR_POINTERS_BY_Y:
  sty TEMPREG
  LIB_ADDR_STORE_AA org_colors, TEMPPTR
  inc_read_clr_loop:
  LIB_POINTER_ADD_AVV TEMPPTR, <40, >40
  dey
  bne inc_read_clr_loop
  LIB_POINTER_COPY_AA TEMPPTR, clr_read_row_ptr

  LIB_ADDR_STORE_AA DEST_COLOR, TEMPPTR
  ldy TEMPREG
  inc_write_clr_loop:
  LIB_POINTER_ADD_AVV TEMPPTR, <40, >40
  dey
  bne inc_write_clr_loop
  LIB_POINTER_COPY_AA TEMPPTR, clr_write_row_ptr
  rts
