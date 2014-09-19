AUTHORS = "Caleb Jones"
TITLE = "Math Reference"
OUTFILE = cmjmathbook.azw3
CALIBRE := $(shell ebook-convert --version 2>/dev/null)
FILES = Trig.html Integrals.html Vectors.html Derivatives.html LaTeX.m4

all: $(OUTFILE)
html: Book.html

$(OUTFILE): Book.html images/*
# Only try to make the ebook if Calibri is installed
ifdef CALIBRE
	ebook-convert Book.html $(OUTFILE) --authors=$(AUTHORS) --title=$(TITLE) --language=en
else
	@echo "Calibre is not installed! Skipping ebook compiliation."
	@echo "Try installing Calibre from 'http://calibre-ebook.com/download'"
endif
# Just to make it shut up
images/*:

Book.html.in: book.h $(FILES)
	gcc book.h -o Book.html.in -P -E -w

Book.html: Book.html.in LaTeX.m4
	m4 Book.html.in | python imgdownloader.py > Book.html

clean:
	rm -f Book.html Book.html.in images/* $(OUTFILE)

install:
	cp $(OUTFILE) /media/Kindle/documents/
