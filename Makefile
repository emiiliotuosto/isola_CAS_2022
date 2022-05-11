title = "isola_CAS_2022" # this should now be set by ~/bin/setlatex
LATEX = latexmk -f -latex="pdflatex --shell-escape"
BIBTEX = bibtex
TEX = main
host := $(shell hostname -s)
SHOWOPT = -p -g -z -e 15:35 -n bottom 
single=single_file

all:
	$(LATEX) $(TEX).tex
	$(warning **** WARNINGS ****)
	grep Warning $(TEX).log

bib:
	$(BIBTEX) $(TEX)

e:
	emacs -T $(title) --reverse --no-splash -mm $(TEX).tex

single:
	$(MAKE) all
	latexpand --makeatletter -expand-bbl $(TEX).bbl $(TEX).tex > $(single).tex
	$(warning **** WARNINGS ****)
	$(LATEX) $(single).tex
	grep Warning $(single).log

clean:
	$(MAKE) autorm
	find . -name "*~" -exec rm -rf {} \;
	find . -name "*.aux" -exec rm -rf {} \;
	find . -name "*.axp*" -exec rm -rf {} \;
	find . -name "*.bbl" -exec rm -rf {} \;
	find . -name "*.blg" -exec rm -rf {} \;
	find . -name "*.fdb*" -exec rm -rf {} \;
	find . -name "*.fls*" -exec rm -rf {} \;
	find . -name "*.log" -exec rm -rf {} \;
	find . -name "*.out" -exec rm -rf {} \;
	find . -name "*.snm" -exec rm -rf {} \;
	find . -name "*.spl*" -exec rm -rf {} \;
	find . -name "*.synctex.gz" -exec rm -rf {} \;
	find . -name "*.toc*" -exec rm -rf {} \;
	find . -name "*.vtc*" -exec rm -rf {} \;

autorm:
	find . -name "auto" -exec rm -rf {} \;

singlerm:
	find . -name "$(single).*" -exec rm -rf {} \;

show:
	pdfpc $(SHOWOPT) $(TEX).pdf

