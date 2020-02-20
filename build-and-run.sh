#! /usr/bin/env bash

rm viewer_hires.prg
rm viewer_hires.o

cl65 -o viewer_hires.prg -u __EXEHDR__ -t c64 -C "c64-asm.cfg" viewer_hires.asm && \
open -a VirtualC64 viewer_hires.prg
