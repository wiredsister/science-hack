pkgs := electron

run:clientclean all clean
	electron .

all:
	@ocamlfind ocamlc fruitbat.ml -package $(pkgs) -linkpkg
	@js_of_ocaml --debug-info --pretty a.out -o fruitbat.js
	@ocamlfind ocamlc fruitbat_render.ml -package $(pkgs) -linkpkg
	@js_of_ocaml --debug-info --pretty a.out -o fruitbat_render.js
	@echo "Now Compiling Sass files..."
	node-sass client/sass/main.scss client/css/main.css \
	--output-style=compressed --output --source-map=true
	@echo "Compiled"

watch:
	node-sass client/sass/main.scss client/css/main.css \
	--watch --output-style=expanded

clientclean:
	@rm -f client/css/main.css client/css/main.css.map

clean:
	@rm -f fruitbat.cmi fruitbat.cmo fruitbat.cmt a.out \
	fruitbat_render.cmi fruitbat_render.cmo fruitbat_render.cmt a.out

.PHONY:clean all watch clientclient
