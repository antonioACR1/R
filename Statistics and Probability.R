##The following is an example of Poisson distribution.

Units_April_2009 <- as.table(cbind(Day=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30),Units=c(1,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0,0,0,1,1,1)))
Units_April_2009
##The previous table will show the units sold per day during April 2009 
##Get the mean of the units sold during April 2009
Units_Mean<-mean(Units_April[,'Units'])
##Now I compute the probability of selling 2 units in May 1, 2009 using Poisson distribution formula applied to the units sold during April.
probability_2units <- dpois(2,Units_Mean)
probability_2units
##the result is 0.02, which means that there is only a 2% probability of selling 2 units in May 1.


##The following is an example of the chi-square test of independence.

## The following table shows a contingency table consisting of 14 manufacturers and 5 countries together with the number of units sold by each manufacturer in each country.
a_table<-as.table(cbind(c(818,13873,277,8471,440,548,22068,99,8911,552,2162,263,16221,615),c(68769,552479,35895,239666,42399,38788,680833,3169,434210,67946,144286,24810,958475,52528),
c(2205,37907,893,22899,919,1277,63928,210,24793,1226,5904,545,52457,1844),c(3988,63148,998,29342,1676,1823,86752,405,32303,2646,9583,625,79203,2258),
c(2772,40228,1134,16734,1164,1733,51855,286,18732,2465,3993,881,89807,2288)))
dimnames(a_table) <- list(Manufacturer=c("Abbas","Aliqui","Barba","Currus","Fama","Leo","Natura","Palma","Pirum","Pomum","Quibus","Salvus","VanArsdel","Victoria"),Countries=c("Canada","USA","Mexico","France","Germany"))
a_table
##In other words, I have 2 categorical variables (manufacturers and countries). I would like to know if these two variables are dependent or independent.
##I will apply the chi-square test for independence to answer this question.
##The null hypothesis is that the two variables are independent. 
library(MASS)
chisq.test(a_table)
##This yields a p-value equal to 2.2 x 10^{-16}.
##If the confidence level is 95%, then the significance level is 0.05 which is bigger than the p-value.
##Therefore, we reject the null hypothesis, which means that there is a possible relation between the manufacturers and the country in which they are selling.

