#First I open MySQL and choose a database: 'USE sales;'
#I have three databases here: Products, Manufacturers and Locations.


#Now I will to connect to MySQL from R
install.packages("RMySQL")
library(RMySQL)
mydb <- dbConnect(MySQL(), user='*****', password='*****', dbname='sales', host='localhost')

#Now I create a new table in MySQL called 'France': 'CREATE TABLE France (ProductID int, 
#Date date, Zip varchar(1000), Units int, Revenue double(14,4), Country varchar(255));' 

#Check the headers of the previous MySQL table from R
dbListFields(mydb,'France')

#read file and have a look
france <- read.csv(file="~/france.csv", header=TRUE)
head(france)
summary(france)
str(france)

#Convert the factor columns to strings
france$Date <- as.character(france$Date)
france$Zip <- as.character(france$Zip)
france$Country <- as.character(france$Country)

#The date format in MySQL is %Y/%m/%d but the column 'Date' (as string) in my dataframe 'france' has the format %m/%d/%Y.
#Therefore, I will split 'Date' and then paste the day,month and year so that it coincides with the date format of MySQL.

#First split and then to dataframe
y<-as.data.frame(strsplit(france[1:314750,2],"/"))
head(y)
#Transpose
y1<-t(y)
head(y1)
str(y1)

#Now paste all these elements with the required order and insert them into MySQL together with the other columns

for(i in 1:314750){d1<-paste(y1[i,3],"/",y1[i,1],"/",y1[i,2],sep="")
dbGetQuery(mydb,paste("INSERT INTO France (ProductID,Date,Zip,Units,Revenue,Country) VALUES (",france[i,1],",'",d1,"','",france[i,3],"',",france[i,4],",",france[i,5],",'",france[i,6],"')"))
}


#Just for the sake of it, I will select the average of units sold by each manufacturer during April, 1999 in France.
query3 <- "SELECT Products.Manufacturer, AVG(France.Units) FROM France INNER JOIN Products ON France.ProductID = Products.ProductID WHERE France.Date BETWEEN '1999/04/01' AND '1999/04/30' GROUP BY Products.Manufacturer"
query3
df3<-dbGetQuery(mydb,query3)
df3

#Now I select those rows in the table 'table' coming from manufacturer 1 during April, 1999.
query4 <- "SELECT * FROM France INNER JOIN Products ON France.ProductID = Products.ProductID WHERE Products.Manufacturer = 1 AND France.Date BETWEEN '1999/04/01' AND '2015/12/30'"
query4
df4<-dbGetQuery(mydb,query4)

#Have a look
head(df4)
str(df4)

#There are 71 observations.
#Suppose Manufacurer 1 claims to sell an average of 1.5 units during April, 1999.
#Suppose the units shown in df4 represent a sample selected by simple random sampling.
#We can use one sample t-test to test whether or not the average is 1.5
#The null hypothesis is that the average is 1.5.

#Now run the test in R. The significance level is 0.05.
t.test(df4$Units,mu=1.5)

#The p-value is less than 0.05, which means that we should reject the null hypothesis.





