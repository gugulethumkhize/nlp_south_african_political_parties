# Natural Language Processing (NLP): South African Political Parties


**Problem**

Political manifestos contain large amounts of unstructured text, making it 
difficult to compare political language, recurring themes, and differences in 
political framing. Similarly, student reviews can provide insights 
into students' experiences of data science courses, but their sentiment must 
be analysed systematically.

This project applies NLP techniques to compare the 2024 
Economic Freedom Fighters (EFF) and Democratic Alliance (DA) manifestos and 
analyse student sentiment towards a data science course at DSE University.



**Dataset**

- **EFF 2024 manifesto:** Text extracted from the EFF political manifesto using 
optical character recognition (OCR).
- **DA 2024 manifesto:** Text extracted from the DA political manifesto using 
optical character recognition (OCR).
- **Data science course reviews:** Simulated student reviews from 
DSE University, a fictional institution used for illustrative analysis.



**Methods**

- Extracted text from PDF manifestos using `pdftools` and OCR.
- Cleaned text by removing punctuation, correcting line breaks, removing excess 
whitespace, and converting text to lowercase.
- Tokenised text into individual words using `tidytext`.
- Removed stop words and numeric tokens to focus on meaningful vocabulary.
- Calculated word frequencies and identified the 10 most frequent words in each 
manifesto.
- Created bar charts of the 20 most frequent words and generated word clouds for
both manifestos.
- Combined manifesto word-frequency data and examined textual correlation using 
Pearson's correlation test.
- Created a bivariate scatter plot with a linear regression line to explore 
relationships between word frequencies and distinguish shared development themes
from other vocabulary.
- Applied the Bing sentiment lexicon to student reviews to identify positive and
negative terms.
- Visualised the most frequent sentiment-associated words using faceted bar 
charts.



**Tools**

- **R and RStudio:** Text processing, statistical analysis, and visualisation.
- **tidyverse:** Data manipulation and workflow organisation.
- **tidytext:** Tokenisation, stop-word removal, and sentiment analysis.
- **dplyr:** Data manipulation and combining data frames.
- **ggplot2:** Word-frequency charts, sentiment plots, and regression 
visualisation.
- **pdftools:** PDF text extraction.
- **tesseract:** Optical character recognition.
- **wordcloud and RColorBrewer:** Word-cloud generation and colour palettes.
- **stringr:** Text cleaning and pattern matching.
- **ggrepel:** Improved word-label placement in plots.
- **scales and reshape2:** Supporting visualisation and data manipulation.



**Key Insights and Outcomes**

*Political Manifesto Analysis*

The 10 most frequent words in the EFF manifesto included *EFF* (45 occurrences),
*government* (32), and *economic* (24). In the DA manifesto, the most frequent 
words included *DA* (165 occurrences), *south* (108), and *government* (78).

Pearson's correlation test returned a correlation coefficient of approximately 
**−0.10** ((p < 0.001)), indicating a weak negative relationship between the 
word-frequency variables used in the analysis. This supports the hypothesis that
the manifestos show low textual correlation within the approach taken.

The regression visualisation highlighted potential shared development themes, 
including education and employment-related vocabulary, alongside differences in 
word usage. These overlaps may reflect common national challenges rather than 
direct ideological alignment.

The analysis suggests differences in vocabulary and political framing. 
However, word-frequency correlation alone does not establish the full 
ideological positions of either party, and the project's topic-related 
hypotheses should be interpreted as exploratory as a formal topic-modelling 
algorithm was not required.



*Student Review Sentiment Analysis*

The Bing sentiment lexicon was selected to classify words as positive or 
negative. Frequently occurring positive terms included *helped*, *rewarding*, 
*enjoy*, *confident*, and *confidence*. The negative term highlighted in the 
interpretation was *challenging*.

The findings suggest that student reviews about the data science course were 
generally positive. The term *challenging* may reflect the academic demands of 
the course rather than dissatisfaction alone.

These results provide encouraging evidence about students' reported experiences. 
However, sentiment analysis of reviews cannot independently establish actual 
course demand, explain enrolment growth, or determine the likely effect of 
additional scholarships.



**Project Outputs**

- Top 10 word-frequency tables for the EFF and DA manifestos.
- Bar charts of the 20 most frequent words in each manifesto.
- Word clouds for both political manifestos.
- Combined EFF and DA word-frequency data.
- Pearson correlation test results.
- Bivariate regression plot comparing manifesto word frequencies.
- Sentiment analysis visualisation for data science course reviews.
- R script containing the analysis code.
- R Markdown report documenting the workflow and interpretation.



**Reproducibility**

The EFF and DA manifestos are available as PDF documents. The student 
course-review dataset is a simulated dataset and must be obtained or recreated 
separately in CSV format.

Install the required packages in R:

```
install.packages(c(
  "tidyverse", "pdftools", "tidytext", "wordcloud",
  "wordcloud2", "RColorBrewer", "reshape2", "scales",
  "tesseract", "stringr", "ggrepel"
))
```

Load the packages before conducting the analysis:

```
library(tidyverse)
library(pdftools)
library(tidytext)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)
library(reshape2)
library(scales)
library(tesseract)
library(stringr)
library(ggrepel)
```

Import the manifesto PDFs and student-review CSV file into R. The analysis can 
then be conducted in RStudio by writing code to extract and clean the text, 
analyse word frequencies, compare manifesto vocabulary, create visualisations, 
and examine student sentiment.



