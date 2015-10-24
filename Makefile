# pkgs := nodejs,socket_io,express

pkgs := electron

# Do not use it breaks the script, very odd!
define colorecho
      @tput setaf 6
      @echo $1
      @tput sgr0
endef

run:clientclean all clean
	electron .

all:
	@ocamlfind ocamlc fruitbat.ml -package $(pkgs) -linkpkg
	@js_of_ocaml --debug-info --pretty a.out -o fruitbat.js
	@echo "Now Compiling Sass files..."
	node-sass client/sass/main.scss client/css/main.css --output-style=compressed --output --source-map=true
	@echo "Compiled"

watch:
	node-sass client/sass/main.scss client/css/main.css --watch --output-style=expanded

clientclean:
	@rm -f client/css/main.css client/css/main.css.map

clean:
	@rm -f fruitbat.cmi fruitbat.cmo fruitbat.cmt a.out

.PHONY:clean
