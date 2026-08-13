# Managing Research Software Projects - build tasks.

.PHONY: site serve check bib clean

site:            ## render HTML with Quarto
	quarto render
	touch docs/.nojekyll

serve:           ## preview the site locally
	quarto preview

check:           ## check structure, spelling, and internal links
	quarto check
	typos
	lychee docs --offline --no-progress

bib:             ## validate the bibliography against citations
	python3 bin/check_bib.py

clean:           ## remove generated and cache files
	rm -rf .quarto _book
	find . -type f -name '*~' -delete
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
