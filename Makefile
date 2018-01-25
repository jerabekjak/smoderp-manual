latexfile = manual_CZ

TEX = pdflatex
BIB = bibtex
d=`date -I`-$(latexfile)
dtmp=/tmp/`date -I`-$(latexfile)

all: $(latexfile).pdf

$(latexfile).pdf: clean 
	$(TEX) $(latexfile)
	$(BIB) $(latexfile)
	$(TEX) $(latexfile)
	$(TEX) $(latexfile)

view :
	okular $(latexfile).pdf &
clean: 
	rm -f  *.dvi *.bbl *.blg *.aux *.log *.spl *.out *.toc 
	
cleanhtml: 
	rm *.html
	
	
tar: 
	tar -hczf $d.tgz *.tex Makefile 1_tex bib config graph img tab *.kilepr 
zip: 
	zip $d.zip *.tex obr/* tex/*.tex *.bib  *.pdf
upload:
	./upload.sh $(latexfile)
	
tikzdopng:	
	$(TEX) -output-directory=img-prep/ img-prep/lichobeznik.tex
	convert -density 600 -limit memory 64MB -limit map 128MB -colorspace RGB img-prep/lichobeznik.pdf img/lichobeznik.png
	$(TEX) -output-directory=img-prep/ img-prep/parabola.tex
	convert -density 600 -limit memory 64MB -limit map 128MB -colorspace RGB img-prep/parabola.pdf img/parabola.png
	$(TEX) -output-directory=img-prep/ img-prep/trojuhelnik.tex
	convert -density 600 -limit memory 64MB -limit map 128MB -colorspace RGB img-prep/trojuhelnik.pdf img/trojuhelnik.png
	$(TEX) -output-directory=img-prep/  img-prep/CZflowch.tex
	convert -density 600 -limit memory 64MB -limit map 128MB -colorspace RGB img-prep/CZflowch.pdf img/CZflowch.png
	
html:	cleanhtml
	htlatex $(latexfile)
