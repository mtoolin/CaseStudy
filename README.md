# CaseStudy
### MSDS 6306 Case Study 1 for Jaime Villanueva, Venkat Kasrala and Michael Toolin
<br>

#### File flow for source files: <br> <br>
__ReadURLData.R__ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;output: edstats_country.csv and gdp.csv <br>
__raw_analysis_GDP.R__ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;input: gdp.csv <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;output: dfgdp_2012_final.csv <br>
__raw_analysis_EDSTATS.R__ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;input: edstats_country.csv and dfgdp_2012_final.csv <br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;output: edstats_final.csv <br>
__merged.R__ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;input: dfgdp_2012_final.csv and edstats_final.csv <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;output: merged_final.csv <br>
__cleaned_merged.R__ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;input: merged_final.csv <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;output: cleaned_merged_final.csv <br>
