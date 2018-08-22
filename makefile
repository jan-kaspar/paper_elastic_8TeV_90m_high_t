all: paper_elastic_8TeV_90m_epl.bbl
	pdflatex paper_elastic_8TeV_90m_epl.tex

paper_elastic_8TeV_90m_epl.bbl : bibliography.bib
	bibtex paper_elastic_8TeV_90m_epl.aux

full:
	pdflatex paper_elastic_8TeV_90m_epl.tex
	bibtex paper_elastic_8TeV_90m_epl.aux
	pdflatex paper_elastic_8TeV_90m_epl.tex
	pdflatex paper_elastic_8TeV_90m_epl.tex
