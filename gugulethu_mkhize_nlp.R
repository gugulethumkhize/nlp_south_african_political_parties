## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse)
library(ggplot2)
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
library(dplyr)


## ----results='hide'--------------------------------------------------------------------------------------------------------------------------------------------------------------
eff <- pdf_ocr_text("eff_manifesto_2024.pdf")%>%
   paste(collapse = " ")



## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
eff_clean <- eff %>%
  str_replace_all("\n", " ") %>%                 
  str_replace_all("-\\s+", "") %>%                
  str_replace_all("[^[:alnum:][:space:]]", " ") %>%
  str_squish() %>% 
  tolower()

eff_df <- tibble(text = eff_clean)


DA_manifesto_2024 <- list.files(pattern = "DA_manifesto_2024.pdf") %>% 
  map(pdf_text) %>%
  unlist() %>%
  paste(collapse = " ") 

DA_clean <- DA_manifesto_2024 %>% 
   str_replace_all("\n", " ") %>%                 
  str_replace_all("-\\s+", "") %>%                
  str_replace_all("[^[:alnum:][:space:]]", " ") %>%
  str_squish() %>%
  tolower()

DA_df <- tibble(text = DA_clean)

tidy_eff <- eff_df %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words, by = "word") %>%
  filter(!str_detect(word, "[0-9]")) %>%
  count(word) %>% 
  arrange(desc(n));tidy_eff


## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
  head(tidy_eff, 10)


## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
 tidy_DA <- DA_df %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words, by = "word") %>%
  filter(!str_detect(word, "[0-9]")) %>%
  count(word) %>% 
  arrange(desc(n));tidy_DA


## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
  head(tidy_DA, 10)


## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
eff_top20_words <- tidy_eff %>%
  arrange(desc(n)) %>% 
  head(20) %>% 
  mutate(word = reorder(word,n)) %>% 
  ggplot(aes(n, word)) +
  geom_col(fill="darkgreen") +
  labs(
    title = "Top 20 Most Repeated Words for the EFF 2024 Manifesto",
    x = "Frequency (n)",
    y = NULL)+
  theme_minimal()+
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5))


eff_top20_words 
ggsave("Top20_Most_Repeated_Words_EFF.png", eff_top20_words, width = 9.5, height = 7, dpi = 300)



## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
DA_top20_words <- tidy_DA %>%
  arrange(desc(n)) %>% 
  head(20) %>% 
  mutate(word = reorder(word,n)) %>% 
  ggplot(aes(n, word)) +
  geom_col(fill="darkred") +
  labs(
    title = "Top 20 Most Repeated Words for the DA 2024 Manifesto",
    x = "Frequency (n)",
    y = NULL)+
theme_minimal()+
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5))

DA_top20_words
ggsave("Top20_Most_Repeated_Words_DA.png", DA_top20_words, width = 9.5, height = 7, dpi = 300)


## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
eff_wordcloud <- wordcloud(
  words = tidy_eff$word,
  freq = tidy_eff$n,
  min.freq = 2,           
  random.order = FALSE,    
  colors = brewer.pal(8,"Dark2"))




## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
png("EFF_Wordcloud.png", width = 2850, height = 2100, res = 300)

wordcloud(
  words = tidy_eff$word,
  freq = tidy_eff$n,
  min.freq = 2,
  random.order = FALSE,
  colors = brewer.pal(8, "Dark2")
)

dev.off()



## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
DA_wordcloud <- wordcloud(
  words = tidy_DA$word,
  freq = tidy_DA$n,
  min.freq = 2,           
  random.order = FALSE,    
  colors = brewer.pal(8,"Dark2"))




## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------

png("DA_Wordcloud.png", width = 2850, height = 2100, res = 300)

wordcloud(
  words = tidy_DA$word,
  freq = tidy_DA$n,
  min.freq = 2,
  random.order = FALSE,
  colors = RColorBrewer::brewer.pal(8, "Dark2")
)

dev.off()



## ----results='hide'--------------------------------------------------------------------------------------------------------------------------------------------------------------
 eff <- pdf_ocr_text("eff_manifesto_2024.pdf")%>%
   paste(collapse = " ")


## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
eff_clean <- eff %>%
  str_replace_all("\n", " ") %>%                 
  str_replace_all("-\\s+", "") %>%                
  str_replace_all("[^[:alnum:][:space:]]", " ") %>%
  str_squish() %>% 
  tolower()


eff_df <- tibble(text = eff_clean)


DA_manifesto_2024 <- list.files(pattern = "DA_manifesto_2024.pdf") %>% 
  map(pdf_text) %>%
  unlist() %>%
  paste(collapse = " ") 

DA_clean <- DA_manifesto_2024 %>% 
   str_replace_all("\n", " ") %>%                 
  str_replace_all("-\\s+", "") %>%                
  str_replace_all("[^[:alnum:][:space:]]", " ") %>%
  str_squish() %>% 
  tolower()

DA_df <- tibble(text = DA_clean)

New_tidy_eff <- eff_df %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words, by = "word") %>%
  filter(!str_detect(word, "[0-9]")) %>%
  count(word, name = "EFF")
 
  New_tidy_DA <- DA_df %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words, by = "word") %>%
  filter(!str_detect(word, "[0-9]")) %>%
  count(word, name = "DA")
  
 eff_da_combined <- bind_rows(New_tidy_eff, New_tidy_DA) %>% 
   replace_na(list(EFF = 0, DA = 0)) %>% 
   mutate(Total_n = EFF + DA) %>% 
   arrange(desc(Total_n))
    
  head(eff_da_combined, 10)


## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
cor.test(
  eff_da_combined$EFF,
  eff_da_combined$DA,
  method = "pearson"
)


## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
shared_themes <- c("education", "employment", "infrastructure", "health", "housing", "jobs")

eff_da_sync <- eff_da_combined %>% 
  mutate(
    theme_type = if_else(word %in% shared_themes, "Shared_Development_Themes", "Distinct_Ideological_Themes")
  )

top_words <- eff_da_sync %>% 
  top_n(80, EFF + DA)

EFF_DA_Word_Frequencies <- ggplot(eff_da_sync, aes(x = EFF, y = DA)) +
  geom_point(aes(colour = theme_type), alpha = 0.6) +
  geom_text_repel(
    data = top_words,
    aes(label = word),
    size = 3,
    max.overlaps = 60,
    colour = "black"
  ) +
  geom_smooth(method = "lm", se = FALSE, colour = "red", linetype = "dashed") +
  labs(
    title = "Bivariate Regression: EFF & DA Word Frequencies",
    subtitle = "Highlighting shared development themes between the two manifestos",
    x = "EFF Word Frequency",
    y = "DA Word Frequency"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", colour = "blue", hjust = 0.5),
    plot.subtitle = element_text(size = 10, colour = "blue", hjust = 0.5),
    legend.position = "bottom"
  )

EFF_DA_Word_Frequencies
ggsave("EFF_and_DA_Bivariate.png", EFF_DA_Word_Frequencies, width = 9.5, height = 7, dpi = 300)



## ----warning=FALSE, message=FALSE------------------------------------------------------------------------------------------------------------------------------------------------
data_science_reviews_df <- read_csv("data_science_reviews.csv")

data(stop_words)

tokens_data_science_reviews <- data_science_reviews_df %>% 
  unnest_tokens(word, review) %>% 
  anti_join(stop_words, by = "word") %>% 
  filter(!str_detect(word, "[0-9]")) %>% 
  filter(str_detect(word, "[a-z]"))
  
sentiment_bing <- tokens_data_science_reviews %>%
  inner_join(get_sentiments("bing"), by = "word")%>%
  count(word, sentiment, sort = TRUE)

data_science_course_sentiments <- sentiment_bing %>%
  group_by(sentiment) %>%
  top_n(15, n) %>%      
  ungroup() %>%
  mutate(word = reorder_within(word, n, sentiment)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  scale_x_reordered() +
  coord_flip() +
  labs(title = "Data Science Course Sentiment Scores",
       x = NULL, y = "Count")+
  theme_minimal()+
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5))

data_science_course_sentiments
ggsave("Data_Science_Course_Scores.png", data_science_course_sentiments, width = 9.5, height = 7, dpi = 300)




