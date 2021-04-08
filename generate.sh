#!/bin/env sh

# PREPARATION
echo "" > generate.log
TOTAL=10

# MAIN LOOP
for ((i = 1; i <= TOTAL; i++))
do
	number=$(printf "%03d" $i)
	echo -en "\r Converting $i/$TOTAL"

	echo "$number" >> generate.log

	sed "s/number/$i/g" template.tex > vectorian$number.tex
	xelatex vectorian$number.tex \
		>> generate.log 2>> generate.log

	inkscape vectorian$number.pdf \
		--export-area-drawing \
		--export-filename svg/vectorian$number.svg \
		>> generate.log 2>> generate.log

	echo "\n\n" >> generate.log
done

# REMOVE AUXILIARY FILES
latexmk -c vectorian*.tex >> generate.log 2>> generate.log
latexmk -C vectorian*.tex >> generate.log 2>> generate.log
rm vectorian*.tex
