AUTHORS = "Caleb Jones"
TITLE = "Math Reference"
OUTFILE = cmjmathbook.mobi
FILES = Trig.html Integrals.html

all: $(OUTFILE)

$(OUTFILE) : Book.html
	ebook-convert Book.html $(OUTFILE) --authors=$(AUTHORS) --title=$(TITLE) --language=en

Book.html : book.h $(FILES)
	gcc book.h -o Book.html -P -E

clean:
	rm -f Book.html $(OUTFILE)

install:
	cp $(OUTFILE) /media/Kindle/documents/
