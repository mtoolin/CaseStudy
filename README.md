# CaseStudy
MSDS 6306 Case Study 1 for Jamie Villenueva, Venkat Kasrala and Michael Toolin

<br>
<br>

File flow for source files: <br>
ReadURLData.R <br> 
        output: edstats_country.csv and gdp.csv
raw_analysis_GDP.R <br>
        input: gdp.csv
        output: dfgdp_2012_final.csv
raw_analysis_EDSTATS.R <br>
        input: edstats_country.csv  
        output: edstats_final.csv
merged.R <br>
        input: dfgdp_2012_final.csv and edstats_final.csv
        output: merged_final.csv
cleaned_merged.R <br>
        input: merged_final.csv
        output: cleaned_merged_final.csv
