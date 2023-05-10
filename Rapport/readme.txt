Convertir le fichier en HTML
pandoc RapportBDD.md --css=style.css --standalone --toc --toc-depth=1 --section-divs -o rapport.html

Convertir ledit fichier en PDF
pandoc RapportBDD.md --css=style.css --pdf-engine=prince --standalone --toc --toc-depth=1 --section-divs -o rapport.pdf