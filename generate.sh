#!/bin/env sh

for i in {1..196}
do
	number=$(printf "%03d" $i)
	sed "s/number/$i/g" template.tex > vectorian$number.tex
	latexmk vectorian$number.tex
	inkscape vectorian$number.pdf --export-area-drawing --export-filename svg/vectorian$number.svg
done

latexmk -c vectorian*.tex
latexmk -C vectorian*.tex
rm vectorian*.tex
