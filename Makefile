REQUIRED_PACKAGES = texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra lmodern texlive-luatex texlive-xetex latexmk

.PHONY: main clean check_dependencies

main: poster.pdf

check_dependencies:
	@if [ "$(shell uname -s)" = "Linux" ]; then \
		for pkg in $(REQUIRED_PACKAGES); do \
			if ! dpkg -l | grep -q $$pkg; then \
				echo "$$pkg is not installed. Installing..."; \
				sudo apt-get install -y $$pkg; \
			else \
				echo "$$pkg is already installed."; \
			fi; \
		done; \
	fi

poster.pdf: check_dependencies
	latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf poster.tex

clean:
	latexmk -pdf -C
