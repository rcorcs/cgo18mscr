#
# Makefile for acmart package
#
# This file is in public domain
#
# $Id: Makefile,v 1.10 2016/04/14 21:55:57 boris Exp $
#

PACKAGE=acmart

SAMPLES=cgo18mscr.tex



#PDF = $(PACKAGE).pdf ${SAMPLES:%.tex=%.pdf} acmguide.pdf
PDF = ${SAMPLES:%.tex=%.pdf}

TEXSRCS = abstract.tex intro.tex motivation.tex overview.tex preamble.tex related.tex results.tex setup.tex cgo18mscr.tex

all:  ${PDF} cgo18mscr.pdf


%.pdf:  %.dtx   $(PACKAGE).cls  $(TEXSRCS)
	pdflatex $<
	- bibtex $*
	pdflatex $<
	- makeindex -s gind.ist -o $*.ind $*.idx
	- makeindex -s gglo.ist -o $*.gls $*.glo
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done


acmguide.pdf: $(PACKAGE).dtx $(PACKAGE).cls
	pdflatex -jobname acmguide $(PACKAGE).dtx
	- bibtex acmguide
	pdflatex -jobname acmguide $(PACKAGE).dtx
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' acmguide.log) \
	do 	pdflatex -jobname acmguide $(PACKAGE).dtx; done

%.cls:   %.ins %.dtx  
	pdflatex $<

cgo18mscr.pdf:  $(PACKAGE).cls ACM-Reference-Format.bst $(TEXSRCS)
	pdflatex cgo18mscr
	- bibtex cgo18mscr
	pdflatex cgo18mscr
	pdflatex cgo18mscr

#sample-manuscript.pdf \
#sample-acmsmall.pdf \
#sample-acmlarge.pdf \
#sample-acmtog.pdf: samplebody-journals.tex

#sample-sigconf.pdf \
#sample-sigconf-authordraft.pdf \
#sample-sigplan.pdf \
#sample-sigchi.pdf: samplebody-conf.tex

.PRECIOUS:  $(PACKAGE).cfg $(PACKAGE).cls

clean:
	$(RM)  $(PACKAGE).cls *.log *.aux \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls *.cut *.hd \
	*.dvi *.ps *.thm *.tgz *.zip *.rpi

distclean: clean
	$(RM) $(PDF) *-converted-to.pdf

#
# Archive for the distribution. Includes typeset documentation
#
archive:  all clean
	tar -C .. -czvf ../$(PACKAGE).tgz --exclude '*~' --exclude '*.tgz' --exclude '*.zip'  --exclude CVS --exclude '.git*' $(PACKAGE); mv ../$(PACKAGE).tgz .

zip:  all clean
	zip -r  $(PACKAGE).zip * -x '*~' -x '*.tgz' -x '*.zip' -x CVS -x 'CVS/*'
