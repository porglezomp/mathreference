AUTHORS = "Caleb Jones"
TITLE = "Math Reference"
OUTFILE = cmjmathbook.azw3
FILES = Trig.html Integrals.html Vectors.html LaTeX.m4

all: $(OUTFILE)

$(OUTFILE): Book.html images/*
	ebook-convert Book.html $(OUTFILE) --authors=$(AUTHORS) --title=$(TITLE) --language=en
images/*:

Book.html.in: book.h $(FILES)
	gcc book.h -o Book.html.in -P -E

Book.html: Book.html.in LaTeX.m4
	m4 Book.html.in | python imgdownloader.py > Book.html

clean:
	rm -f Book.html Book.html.in images/* $(OUTFILE)

install:
	cp $(OUTFILE) /media/Kindle/documents/
