
for(var i = 0; i < 40; i++) {
console.log(`
;=============================== ${i}
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
  sta (bmp_write_clmn_ptr),y`);
}
