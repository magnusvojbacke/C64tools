.include "lib_misc.asm"
.include "lib_ptrs.asm"

.segment "CODE"

sei
lda #$0b          ; Dark gray
sta $d020         ; Border color

lda $d011
ora #$20          ; Set bitmap mode
sta $d011


;$DD00
; 56576
; #%00001000  ; Set vic bank 1
lda $dd00
and #%11111100
ora #%00000001
sta $dd00

;$D018
;53272
lda $d018
; ora #$38
ora #%00111000          ; Set screen memory to $0c00, bitmap location to $2000
sta $d018
cli

LIB_COPY_MEM_GT256_AAA org_bitmap, DEST_BITMAP, $BF40
LIB_COPY_MEM_GT256_AAA org_colors, DEST_COLOR, $8FE8

jmp main
count: .byte $00, $00
spacez: .byte $00
rowcount_frame: .byte $00
rowcount_scene: .byte $00

main:
spacechk:
lda $dc01
cmp #$ef
beq storedown
lda spacez
beq spacechk
bne continue

storedown:
lda #1
sta spacez
jmp spacechk

continue:
lda #0
sta spacez

lda #<org_bitmap
sta bmp_read_row_ptr
sta bmp_read_clmn_ptr
lda #>org_bitmap
sta bmp_read_row_ptr+1
sta bmp_read_clmn_ptr+1

lda #<DEST_BITMAP
sta bmp_write_row_ptr
sta bmp_write_clmn_ptr
lda #>DEST_BITMAP
sta bmp_write_row_ptr+1
sta bmp_write_clmn_ptr+1

lda #<org_colors
sta clr_read_row_ptr
lda #>org_colors
sta clr_read_row_ptr+1

lda #<DEST_COLOR
sta clr_write_row_ptr
lda #>DEST_COLOR
sta clr_write_row_ptr+1

sei
  lda #0
  sta rowcount_scene
  lda #25
  sta rowcount_frame
  lda count
  and #%00000001
  beq effect_scene
  LIB_COPY_MEM_GT256_AAA org_bitmap, DEST_BITMAP, $BF40
  LIB_COPY_MEM_GT256_AAA org_colors, DEST_COLOR, $8FE8
  inc count
  jmp main

  effect_scene:
  ; move read/write line forward by rowcount_scene
  ldy rowcount_scene
  beq effect_frame
  jsr LIB_MOVE_BMP_POINTERS_BY_Y

  ldy rowcount_scene
  jsr LIB_MOVE_CLR_POINTERS_BY_Y

  lda #25
  sec
  sbc rowcount_scene
  sta rowcount_frame

  effect_frame:
  LIB_UNROLL_LINE_COPY_AA bmp_read_clmn_ptr, bmp_write_clmn_ptr
  LIB_COPY_MEM_AAV clr_read_row_ptr, clr_write_row_ptr, 40

  LIB_POINTER_ADD_AVV bmp_write_row_ptr, <320, >320 ;0D6C
  lda bmp_write_row_ptr
  sta bmp_write_clmn_ptr
  lda bmp_write_row_ptr+1
  sta bmp_write_clmn_ptr+1

  lda bmp_read_row_ptr
  sta bmp_read_clmn_ptr
  lda bmp_read_row_ptr+1
  sta bmp_read_clmn_ptr+1
  LIB_POINTER_ADD_AVV clr_write_row_ptr, <40, >40

  dec rowcount_frame
  beq leave_frame
  jmp effect_frame
  leave_frame:
  inc rowcount_scene
  lda rowcount_scene
  cmp #24
  beq leave_scene
  jmp effect_scene
  leave_scene:
  inc count
  jmp main
cli

jmp main

.segment "COLOR"
; .assert * = $0c00, error, "color is off"
org_colors: .incbin "colors_test.bin"
.segment "BITMAP"
; .assert * = $2000, error, "bitmap is off"
org_bitmap: .incbin "bitmap_test.bin"
