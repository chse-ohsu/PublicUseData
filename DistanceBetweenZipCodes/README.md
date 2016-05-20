# Calculate (Great Haversine) Distance Between Zip Codes

This R code calculates the distance between zip centroids.

## Code examples

See "DistanceBtwnZipCodes.R"

## Additional context

```
From: Benjamin Chan 
Sent: Monday, May 16, 2016 9:47 PM
Subject: RE: zip code centroid distance data

Oh, is it the great circles thing? The geosphere package for R has a distHaversine() function to do this. You need the lon-lat for each zip code to implement. There's an open issue on the PUD GitHub to read in a zip code database, which includes lon-lat coordinates. It'll be cake to implement distHavesine() to that data set. I'm assigning Stephanie to it. 

https://github.com/chse-ohsu/PublicUseData/issues/2https://github.com/chse-ohsu/PublicUseData/issues/2

________________________________________
From: Peter Graven
Sent: Monday, May 16, 2016 9:33 PM
Subject: RE: zip code centroid distance data

There is some sas code in the data repository under zip codes that does this. It includes the formula which is pretty cool for any geometry lovers. 


-------- Original message --------
From: Benjamin Chan <chanb@ohsu.edu> 
Date: 5/16/16 9:05 PM (GMT-08:00) 
Subject: RE: zip code centroid distance data 

Stephanie just needed distances at the zip code level. The Google API is tricky because...

"Google Maps appears to limit the number of queries allowed from a single Internet protocol (IP) address within a 24-hour period. This exact limit is not known, but it is not recommended that more than 10,000 to 15,0004 observations be geocoded at any one time from a single IP address."

So not good for large data sets. Really useful when you want to grab distances for street addresses, however.


________________________________________
From: John McConnell
Sent: Monday, May 16, 2016 7:44 PM
Subject: RE: zip code centroid distance data

That NBER thing looks good
There are also some utilities in Stata here, probably similar ones in R if these are the types of things you’re looking for
http://www.stata-journal.com/sjpdf.html?articlenum=dm0053
 
 
From: Benjamin Chan 
Sent: Monday, May 16, 2016 6:54 PM
To: Aaron Mendelson; Jonah Kushner; Ruth Rowland; Christina Charlesworth; Jenny Young; Jonah Kushner; Jonah Todd-Geddes; Konrad Dobbertin; Nicoleta Lupulescu-Mann; Stephan Lindner; Stephanie Renfro; Thomas Meath; Hyunjee Kim; John McConnell; Peter Graven
Subject: zip code centroid distance data
 
Stephanie asked about zip code centroid distance data and a few people said we actually had it. Would it be this from NBER? http://www.nber.org/data/zip-code-distance-database.htmlhttp://www.nber.org/data/zip-code-distance-database.html 
 
If yes, could someone please put your code up for reading/importing it on the Public Use Data Github: https://github.com/chse-ohsu/PublicUseDatahttps://github.com/chse-ohsu/PublicUseData
 
Ideally the code should
1.	Download the data from the appropriate URL to a tempfile
2.	Unzip the tempfile if needed
3.	Process/load it
4.	Display a few rows and maybe some frequency counts of key variables
I say "ideally", not "necessary". Stata, R, or SAS? Doesn't matter. Just get whatever you have up there, even if it's not clean.

```
