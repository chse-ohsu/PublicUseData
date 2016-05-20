#require needed packages
require(data.table)
require(zipcode)
require(geosphere)

#Sample list of zip codes
zip <- c("97218","97214","97232","97239")

#Create table of all unique pairwise zip code combinations (from sample)
table <- data.table(zip1=combn(zip,2)[1,],
                    zip2=combn(zip,2)[2,])

#Add on zip code centroid latitudes and longitudes
data(zipcode)
zipcode <- data.table(zipcode)

setnames(table,"zip1","zip")
table <- merge(table, zipcode, by="zip", all.x=TRUE)
table <- table[, list(zip1=zip,
                      lat1=latitude,
                      long1=longitude,
                      zip2)]

setnames(table,"zip2","zip")
table <- merge(table, zipcode, by="zip", all.x=TRUE)
table <- table[, list(zip1,
                      lat1,
                      long1,
                      zip2=zip,
                      lat2=latitude,
                      long2=longitude)]

#Add on "great-circle-distance"/"as the crow flies" distance between each pair of zip codes.
#Specify radius of earth in miles to get distances in terms of miles (default is meters)
table <- table[, dist := distHaversine(table[,list(long1,lat1)], table[,list(long2,lat2)], r=3959)]

#Display result
table
