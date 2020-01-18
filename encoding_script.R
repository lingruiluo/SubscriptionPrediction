# add it to wherever needed

# mean encoding 
train_copy <- train[,]
mean_encoding <- function(dataset, categorical_col, response) {
  categorical_col <- enquo(categorical_col)
  response <- enquo(response)
  temp <- dataset %>% 
    group_by(!!categorical_col,!!response) %>% 
    summarise(n=n()) %>%
    mutate(freq=n/sum(n)) %>%
    filter(!!response==1) %>%
    select(c(!!categorical_col,freq))
  return(temp)
}

train_copy <- merge(train_copy,mean_encoding(train_copy,job,y),by='job') %>% select(-job) %>% mutate(job=freq) %>% select(-freq) 
train_copy <- merge(train_copy,mean_encoding(train_copy,marital,y),by='marital') %>% select(-marital) %>% mutate(marital=freq) %>% select(-freq) 
train_copy <- merge(train_copy,mean_encoding(train_copy,education,y),by='education') %>% select(-education) %>% mutate(education=freq) %>% select(-freq) 
train_copy <- merge(train_copy,mean_encoding(train_copy,month,y),by='month') %>% select(-month) %>% mutate(month=freq) %>% select(-freq) 
train_copy <- merge(train_copy,mean_encoding(train_copy,day_of_week,y),by='day_of_week') %>% select(-day_of_week) %>% mutate(day_of_week=freq) %>% select(-freq) 
train_copy <- merge(train_copy,mean_encoding(train_copy,poutcome,y),by='poutcome') %>% select(-poutcome) %>% mutate(poutcome=freq) %>% select(-freq) 
train_copy <- merge(train_copy,mean_encoding(train_copy,pdays,y),by='pdays') %>% select(-pdays) %>% mutate(pdays=freq) %>% select(-freq) 
train_copy <- merge(train_copy,mean_encoding(train_copy,campaign,y),by='campaign') %>% select(-campaign) %>% mutate(campaign=freq) %>% select(-freq) 
train_copy <- merge(train_copy,mean_encoding(train_copy,previous,y),by='previous') %>% select(-previous) %>% mutate(previous=freq) %>% select(-freq) 



# label encoding 
train_copy$default <- as.numeric(train_copy$default)-1
train_copy$housing <- as.numeric(train_copy$housing)-1
train_copy$loan <- as.numeric(train_copy$loan)-1



# one hot encoding
for (unique_value in unique(train_copy$contact)) {
  train_copy[paste("contact", unique_value, sep = ".")] <- ifelse(train_copy$contact == unique_value, 1, 0)
}
train_copy <- train_copy %>% select(-contact)



# test 
test_copy <- test[,]

test_copy <- merge(test_copy,mean_encoding(test_copy,job,y),by='job') %>% select(-job) %>% mutate(job=freq) %>% select(-freq) 
test_copy <- merge(test_copy,mean_encoding(test_copy,marital,y),by='marital') %>% select(-marital) %>% mutate(marital=freq) %>% select(-freq) 
test_copy <- merge(test_copy,mean_encoding(test_copy,education,y),by='education') %>% select(-education) %>% mutate(education=freq) %>% select(-freq) 
test_copy <- merge(test_copy,mean_encoding(test_copy,month,y),by='month') %>% select(-month) %>% mutate(month=freq) %>% select(-freq) 
test_copy <- merge(test_copy,mean_encoding(test_copy,day_of_week,y),by='day_of_week') %>% select(-day_of_week) %>% mutate(day_of_week=freq) %>% select(-freq) 
test_copy <- merge(test_copy,mean_encoding(test_copy,poutcome,y),by='poutcome') %>% select(-poutcome) %>% mutate(poutcome=freq) %>% select(-freq) 
test_copy <- merge(test_copy,mean_encoding(test_copy,pdays,y),by='pdays') %>% select(-pdays) %>% mutate(pdays=freq) %>% select(-freq) 
test_copy <- merge(test_copy,mean_encoding(test_copy,campaign,y),by='campaign') %>% select(-campaign) %>% mutate(campaign=freq) %>% select(-freq) 
test_copy <- merge(test_copy,mean_encoding(test_copy,previous,y),by='previous') %>% select(-previous) %>% mutate(previous=freq) %>% select(-freq) 

test_copy$default <- as.numeric(test_copy$default)-1
test_copy$housing <- as.numeric(test_copy$housing)-1
test_copy$loan <- as.numeric(test_copy$loan)-1

for (unique_value in unique(test_copy$contact)) {
  test_copy[paste("contact", unique_value, sep = ".")] <- ifelse(test_copy$contact == unique_value, 1, 0)
}
test_copy <- test_copy %>% select(-contact)



# save encoded dataset to avoid higher memory cost
#write.csv(train_copy, "encoded_train.csv")
#write.csv(test_copy, "encoded_test.csv")

train_copy <- read.csv("encoded_train.csv") %>% select(-X)
test_copy <- read.csv("encoded_test.csv") %>% select(-X)


train_copy$y <- as.factor(train_copy$y)
levels(train_copy$y) <- c("no","yes")
test_copy$y <- as.factor(test_copy$y)
levels(test_copy$y) <- c("no","yes")

