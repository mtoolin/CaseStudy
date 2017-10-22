all: report.html

clean:
	rm -f gdp education gdpClean.txt educationClean.txt mergeData.tsv ggplot.png report.html
	
gdpClean.txt: source/gdpClean.r data/gdp
	cp $< $@

educationClean.txt: source/educationClean.r data/education
	cp $< $@
	
mergeData.tsv: source/mergeData.r gdpClean.txt educationClean.txt
	Rscript $<
	
ggplot.png: source/generateReports.r mergeData.tsv
	Rscript $<

report.html: report.rmd mergeData.tsv ggplot.png
	Rscript -e 'rmarkdown::render("$<")'