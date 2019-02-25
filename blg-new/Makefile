.SUFFIXES: .xml .html .md

ASSETDIR = assets
SOURCEDIR = src
BUILDDIR = gen

SOURCES = $(shell find $(SOURCEDIR) -name '*.md' | sort -r)
ARTICLES = $(patsubst $(SOURCEDIR)/%.md,$(BUILDDIR)/%.html,$(SOURCES))

clean:
	rm -rf $(BUILDDIR)
	mkdir $(BUILDDIR)

assets:
	rsync -r $(SOURCEDIR)/$(ASSETDIR)/ $(BUILDDIR)/assets

finish: $(ARTICLES)
	./finish $(ARTICLES)

deploy:
	cp $(BUILDDIR) /tmp

open:
	${BROWSER} $(BUILDDIR)/index.html

blog: assets $(ARTICLES) $(BUILDDIR)/index.html finish

$(BUILDDIR)/%.md:
	cp $(SOURCEDIR)/$(shell basename $@) $(BUILDDIR)

$(BUILDDIR)/atom.xml: $(ARTICLES) 
	sblg -o $@ -a $(ARTICLES)

$(BUILDDIR)/index.html: $(ARTICLES)
	sblg -o- -t tpl/index.tpl.html $(ARTICLES) > $@
	sed -i "s|$(BUILDDIR)/||g" $@

.xml.html:
	sblg -c -t tpl/article.tpl.html -o $@ $<

.md.xml: 
	$(eval TITLE := $(shell lowdown -X title $< | tr -d '\t'))
	$(eval AUTHOR := $(shell lowdown -X author $< | tr -d '\t'))
	$(eval TAGS := $(shell lowdown -X tags $< | tr -d '\t'))
	$(eval DATE := $(shell lowdown -X date $< | tr -d '\t')) \
  ( echo "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>" ; \
	printf '<article data-sblg-article="1" data-sblg-tags="%s">' "$(TAGS)" ; \
	printf '<h1>%s</h1>\n' "$(TITLE)"; \
	lowdown $< ; \
	echo "</article>" ; ) > $@
