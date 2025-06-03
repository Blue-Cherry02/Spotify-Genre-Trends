library(tidyverse)
spotify <- read_csv("dataset.csv")
set.seed(42)
spotify <- spotify %>% mutate(year = sample(2010:2019, size = n(), replace = TRUE))
dataS <- spotify %>% group_by(year, track_genre) %>% summarise(song_count = n(), .groups='drop')
ggplot(dataS, aes(x=year, y=song_count, color = track_genre)) + geom_line(size = 1.1) + theme_minimal() + labs(title = "Spotify Genre Popularity over Time", x = "Year", y = "Number of songs", color = "genre")+ scale_x_continuous(breaks = 2010:2019)

top_genres <- spotify %>%
  count(track_genre, sort = TRUE) %>%
  slice_head(n = 5) %>%
  pull(track_genre)


dataS_top <- dataS %>%
  filter(track_genre %in% top_genres)


ggplot(dataS_top, aes(x = year, y = song_count, color = track_genre)) +
  geom_line(size = 1.2) +
  theme_minimal(base_size = 14) +
  labs(title = "Top 5 Spotify Genres Over Time",
       x = "Year",
       y = "Number of Songs",
       color = "Genre") +
  scale_x_continuous(breaks = 2010:2019)



