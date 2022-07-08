
  
  ```{r}
library(tidyverse)
library(skimr)
```

## Cleaning Data Set
```{r}
skim(Ottawa_Houses_Cleaned)

rownames(Ottawa.Houses) <- NULL

Ottawa_Houses_Cleaned <- Ottawa.Houses

```

### Cleaning Prices
```{r}
Ottawa_Houses_Cleaned$Price <- substring(Ottawa.Houses$Price, 2, 10)

Ottawa_Houses_Cleaned$Price <- as.numeric(gsub(",","",Ottawa_Houses_Cleaned$Price))
```

### Cleaning Rooms
```{r}
Ottawa_Houses_Cleaned$rooms <- trimws(Ottawa_Houses_Cleaned$rooms, which = c("right"))
Ottawa_Houses_Cleaned$rooms <- substring(Ottawa.Houses$rooms, 1, 2)


Ottawa_Houses_Cleaned$outlier = Ottawa_Houses_Cleaned$rooms == ""    
Ottawa_Houses_Cleaned = filter(Ottawa_Houses_Cleaned, outlier != TRUE)
Ottawa_Houses_Cleaned <- subset(Ottawa_Houses_Cleaned, , -c(outlier))

Ottawa_Houses_Cleaned$rooms <- as.numeric(Ottawa_Houses_Cleaned$rooms)
```

### Cleaning Postal Code
```{r}
Ottawa_Houses_Cleaned$post_code <- substr(Ottawa.Houses$post_code, 10, 7)
```

### Cleaning Type
```{r}
Ottawa_Houses_Cleaned$type <- substring(Ottawa.Houses$type, 1, 5)
```

### Cleaning Tax
```{r}
Ottawa_Houses_Cleaned$tax <- substring(Ottawa.Houses$tax, 2, 6)

Ottawa_Houses_Cleaned$outlier = Ottawa_Houses_Cleaned$tax == ""    
Ottawa_Houses_Cleaned = filter(Ottawa_Houses_Cleaned, outlier != TRUE)
Ottawa_Houses_Cleaned <- subset(Ottawa_Houses_Cleaned, , -c(outlier))

Ottawa_Houses_Cleaned$outlier = Ottawa_Houses_Cleaned$tax == "/A"    
Ottawa_Houses_Cleaned = filter(Ottawa_Houses_Cleaned, outlier != TRUE)
Ottawa_Houses_Cleaned <- subset(Ottawa_Houses_Cleaned, , -c(outlier))

Ottawa_Houses_Cleaned$tax <- as.numeric(gsub(",","",Ottawa_Houses_Cleaned$tax))
```

### Cleaning Bathrooms
```{r}
Ottawa_Houses_Cleaned$Bathrooms <- substring(Ottawa.Houses$Bathrooms, 1, 1)

Ottawa_Houses_Cleaned$outlier = Ottawa_Houses_Cleaned$Bathrooms < 1    
Ottawa_Houses_Cleaned = filter(Ottawa_Houses_Cleaned, outlier != TRUE)
Ottawa_Houses_Cleaned <- subset(Ottawa_Houses_Cleaned, , -c(outlier))

Ottawa_Houses_Cleaned$outlier = Ottawa_Houses_Cleaned$Bathrooms == "N"    
Ottawa_Houses_Cleaned = filter(Ottawa_Houses_Cleaned, outlier != TRUE)
Ottawa_Houses_Cleaned <- subset(Ottawa_Houses_Cleaned, , -c(outlier))

Ottawa_Houses_Cleaned$Bathrooms <- as.numeric(Ottawa_Houses_Cleaned$Bathrooms)
```

### Cleaning Beds
```{r}
Ottawa_Houses_Cleaned$Beds <- as.numeric(Ottawa_Houses_Cleaned$Beds)
```

### Removing Rentals
```{r}
Ottawa_Houses_Cleaned$outlier = Ottawa_Houses_Cleaned$Price < 10000    
Ottawa_Houses_Cleaned = filter(Ottawa_Houses_Cleaned, outlier != TRUE)
Ottawa_Houses_Cleaned <- subset(Ottawa_Houses_Cleaned, , -c(outlier))
```

