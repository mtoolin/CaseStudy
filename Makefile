all: report.html

clean:
	rm -rf data paper/CaseStudy.html report.html
	
download.txt: source/ReadURLData.r
	Rscript $< $@

gdpClean.txt: source/raw_analysis_GDP.r download.txt
	Rscript $< $@
	
educationClean.txt: source/raw_analysis_EDSTATS.r gdpClean.txt
	Rscript $< $@
	
mergeData.tsv: source/merged.r educationClean.txt
	Rscript $<
	
cleanmerged.tsv: source/cleaned_merged.r mergeData.tsv
	Rscript $<

report.html: paper/CaseStudy.Rmd cleanmerged.tsv
	Rscript -e 'rmarkdown::render("$<")'