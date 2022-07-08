
  
  ```{r}
library(tidyverse)
library(rvest)
```


## Links
```{r}
link = ("https://www.remax.ca/on/ottawa-real-estate?pageNumber=1")

page = read_html(link)
```

## Scraping Main Page
```{r}
Price = page %>% 
  html_nodes(".listing-card_price__sL9TT span") %>% 
  html_text()

Beds = page %>% 
  html_nodes(".listing-card_propertyDetail__3OOL0:nth-child(1) span:nth-child(1)") %>% 
  html_text()

Bathrooms = page %>% 
  html_nodes(".listing-card_propertyDetail__3OOL0+ .listing-card_propertyDetail__3OOL0 span:nth-child(1)") %>% 
  html_text()

Address = page %>% 
  html_nodes(".listing-card_address___bLLz span:nth-child(1)") %>% 
  html_text()



```

## Subscraping Functions
```{r}
home_links = page %>% 
  html_nodes(".listing-card_listingCard__G6M8g") %>% 
  html_attr("href")

get_tax = function(page_link) {
  house_page = read_html(page_link)
  house_page = read_html(page_link)
  tax = house_page %>% html_nodes(".listing-detail-bullet-section_propertyDetailsBullet__EevAP:nth-child(1) span+ span") %>% 
    html_text() %>%  paste(collapse = ",")
  return(tax)
}

get_post_code = function(page_link) {
  house_page = read_html(page_link)
  house_page = read_html(page_link)
  post_code = house_page %>% html_nodes(".listing-summary_cityLine__YxXgL") %>% 
    html_text() %>%  paste(collapse = ",")
  return(post_code)
}

get_type = function(page_link) {
  house_page = read_html(page_link)
  house_page = read_html(page_link)
  type = house_page %>% html_nodes(".listing-summary_propertyDetailsRow__PriSV+ .listing-summary_propertyDetailsRow__PriSV span") %>% 
    html_text() %>%  paste(collapse = ",")
  return(type)
}

get_rooms = function(page_link) {
  house_page = read_html(page_link)
  house_page = read_html(page_link)
  rooms = house_page %>% html_nodes(".listing-detail-bullet-section_collapsibleWrapper__BHLoO .residentialDarkColour:nth-child(2) .bullet-section_bulletPointRow__4pBp6:nth-child(1) span+ span") %>% 
    html_text() %>%  paste(collapse = ",")
  return(rooms)
}

tax = sapply(home_links, FUN = get_tax)
post_code = sapply(home_links, FUN = get_post_code)
type = sapply(home_links, FUN = get_type)
rooms = sapply(home_links, FUN = get_rooms)
```


## Scraping Multple Pages with For Loops
```{r}

Ottawa.Houses <- data.frame()

for (page_result in seq(from = 1, to = 65, by = 1)) {
  link = paste0("https://www.remax.ca/on/ottawa-real-estate?pageNumber=",page_result)
  
  page = read_html(link)
  
  Price = page %>% 
    html_nodes(".listing-card_price__sL9TT span") %>% 
    html_text()
  
  Beds = page %>% 
    html_nodes(".listing-card_propertyDetail__3OOL0:nth-child(1) span:nth-child(1)") %>% 
    html_text()
  
  Bathrooms = page %>% 
    html_nodes(".listing-card_propertyDetail__3OOL0+ .listing-card_propertyDetail__3OOL0 span:nth-child(1)") %>% 
    html_text()
  
  Address = page %>% 
    html_nodes(".listing-card_address___bLLz span:nth-child(1)") %>% 
    html_text()  
  
  tax = sapply(home_links, FUN = get_tax)
  post_code = sapply(home_links, FUN = get_post_code)
  type = sapply(home_links, FUN = get_type)
  rooms = sapply(home_links, FUN = get_rooms)
  
  Ottawa.Houses <- rbind (Ottawa.Houses, data.frame(Address, Bathrooms, Beds, tax, post_code, type, rooms, Price))
  
  print(paste("Page:", page_result))  
}
```

