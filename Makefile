# Makefile per generare PDF con Python + Pandoc

# Variabili
PYTHON_SCRIPT = .github/scripts/build-tesina.py
PANDOC_CONFIG = styles/defaults.yml
SOURCE_MD = README.md
OUTPUT_PDF = tesina.pdf

# Trova il titolo dal metadata.yaml

.PHONY: all build clean help python

all: build

help:
	@echo "Comandi disponibili:"
	@echo "  make build    - Genera il PDF"
	@echo "  make clean    - Rimuove file generati"
	@echo "  make help     - Mostra questo messaggio"

build: $(OUTPUT_PDF)
	@echo "PDF generato: $(OUTPUT_PDF)"

$(OUTPUT_PDF): python $(PANDOC_CONFIG)
	@echo "Generando PDF con Pandoc..."
	pandoc --defaults $(PANDOC_CONFIG) $(SOURCE_MD) -o $(OUTPUT_PDF)

python: $(PYTHON_SCRIPT) $(FONT_SCRIPT)
	echo "Eseguendo script Python per generare README.md..."
	python3.11 $(PYTHON_SCRIPT)

clean:
	@rm -f README.md *.pdf bibliography.yaml
	@echo "File generati rimossi"

sync:
	git add .
	git commit -m "."
	git pull --quiet
	git push
	
