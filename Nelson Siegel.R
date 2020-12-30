library(tidyverse)
library(YieldCurve)
library(timeSeries)

# import the data
df1 <- read.csv("daily.csv", header=TRUE, row.names="Date")

# convert the df1 to a timeSeries object
df2 <- as.timeSeries(df1)

# split the data set into october and november
october <- df2[1:22, ]
november <- df2[23:nrow(df2), ]

# set the maturity in months
maturity_df2  <-  c(2*12, 3*12, 5*12, 7*12, 10*12, 30*12)

# compute the beta values for both months
NS_Params_oct <- Nelson.Siegel(rate = october, maturity = maturity_df2)
NS_Params_nov <- Nelson.Siegel(rate = november, maturity = maturity_df2)

# visualize the yield curve for october
y <- NSrates(NS_Params_oct[1, ], maturity_df2)
plot(maturity_df2, october[1, ], main="Fitting Nelson-Siegel yield curve for October",
     xlab=c("Pillars in months"), type="o")
lines(maturity_df2, y, col=2)
legend("topleft",legend=c("observed yield curve","fitted yield curve"),
       col=c(1,2),lty=1)

# visualise the yield curve for november
y2 <- NSrates(NS_Params_nov[2, ], maturity_df2)
plot(maturity_df2, november[2, ], main="Fitting Nelson-Siegel yield curve for November",
     xlab=c("Pillars in months"), type="o")
lines(maturity_df2, y2, col=2)
legend("topleft",legend=c("observed yield curve","fitted yield curve"),
       col=c(1,2),lty=1)
