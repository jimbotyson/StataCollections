webuse set https://www.ucl.ac.uk/~ccaajim/
webuse results, clear
putdocx clear
putdocx begin
* title for word document
putdocx paragraph, style(Title)
putdocx text ("Report on Maths Scores")
* Next we add a description of our data:
putdocx paragraph, style(Heading1)
putdocx text ("Introduction to the data")
putdocx paragraph
putdocx text ("We have data on examination scores out of 100 for 30 students from three classes.")
putdocx paragraph
putdocx text ("Fifteen of the students were male and fifteen female.")
* the nextline saves the word document we have created so far - the replace option will overwrite any existing document with this name.
putdocx save examinationscores, replace

* Add more content
putdocx begin
putdocx paragraph, style(Heading1)
putdocx text ("Summary statistics")
summarize maths
table class, statistic(mean maths) nototals
putdocx collect
return list
putdocx paragraph
putdocx text ("We have the scores for `r(N)' students ")
putdocx text ("with an average maths score of ")
putdocx text (" `r(mean)' "), nformat(%5.2f)
putdocx text (".")
putdocx save examinationscores, append

putdocx begin
putdocx paragraph, style(Heading1)
putdocx text ("Regression results")
regress maths english i.class, noheader
putdocx table mathsreg = etable, title("Linear regression of maths")
putdocx save examinationscores, append