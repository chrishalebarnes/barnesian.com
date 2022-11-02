start:
	bundle exec jekyll serve
build:
	bundle exec jekyll build
clean:
	rm -r _site
fonts:
	find node_modules/@fontsource -type f -name '*.woff' | xargs -I {} cp {} assets/fonts/
icons:
	find node_modules/ionicons/dist/ionicons/svg -type f -name '*.svg' | xargs -I {} cp {} assets/icons/
styles:
	cp node_modules/normalize.css/normalize.css assets/styles/
	bundle exec rougify style base16.monokai.dark > ./styles/syntax.css
.PHONY = start build clean fonts icons styles
