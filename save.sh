#!/bin/bash

tar -czf baks/$(date +%Y%m%d).tar.gz *.* */* Makefile --exclude=*.{img,qed,elf} --exclude=boot/*.{ko,o,elf,img,qed} --exclude=*.{ko,o} --exclude=baks/* --exclude=asm_lst/* --exclude=gcc/* --exclude=boot/f16vol

