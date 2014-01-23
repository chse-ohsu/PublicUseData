NDC Translation Project
=======================

Purpose
-------
Translate NDC codes from the FDA format to the "historical" format used in APAC.

> From: Brie Noble  
> Sent: Wednesday, January 08, 2014 3:33 PM  
> To: Benjamin Chan  
> Cc: Brie Noble; Miriam Elman  
> Subject: RE: NDC codes  
> 
> Hi Ben,
> 
> So are the APAC NDC codes 11 digits without hyphens?
> 
> I am pretty sure to go from the 10 digit codes with hypens to the 11 digit
> codes without hyphens you follow this rule:
> 
> If the 10 digit format is 4-4-2 meaning ####-####-## then you add a leading
> zero to the first segment (0####-####-##) and then drop the hyphens so the 11
> digit code would be 0##########
> 
> If the 10 digit format is 5-3-2 meaning #####-###-## then you add a leading
> zero to the second segment (#####-0###-##) and then drop the hyphens so the 11
> digit code would be #####0#####
> 
> If the 10 digit format is 5-4-1 meaning #####-####-# then you add a leading
> zero to the second segment (#####-####-0#) and then drop the hyphens so the 11
> digit code would be #########0#
> 
> Hope that makes sense. So if I am reading correctly you will have to take the
> package codes reported on the FDA website and transform them to the 11 digit
> code and then merge in with the APAC data.
> 
> Let me know if you need help with the programming in SAS, in the past I think
> I have parsed the string into 3 variables using an array and the scan function
> with a hyphen for a delimiter and then use the length function to assess the
> length of each of the parsed string and then add in the leading zero to
> whichever one doesn’t meet the criteria, (i.e. the first parsed string should
> be length 5, the second length 4, and the third length 3) then you can
> concatenate them together.

> Let me know if you have any questions!
> 
> Best,  
> Brie
> 
> From: Benjamin Chan  
> Sent: Wednesday, January 08, 2014 2:58 PM  
> To: Brie Noble  
> Subject: NDC codes  
> 
> Hey Brie,
> 
> A few months ago I asked you about the format of NDC codes in APAC. I’m
> revisiting this for a different project.
> 
> Here’s the information I got from James Oliver over at OHPR when I asked about
> what format the NDC codes are in in APAC and why I couldn’t merge drug details
> from the FDA website.
> 
>> The NDC field contains package codes in the historical NDC format (length 11,
>> no delimiter, leading zeros preserved). Eventually insurers will need to move
>> away from this format, but AFAIK it is still the EDI transaction standard.
>> 
>> James
> 
> Do you know what this “historical NDC format” is? More importantly, where I
> can download a database of drug details that uses this format?
> 
> For reference, here’s the FDA website from which I’ve downloaded drug
> information from: [http://www.fda.gov/drugs/informationondrugs/ucm142438.htm](http://www.fda.gov/drugs/informationondrugs/ucm142438.htm).
> The NDC database file doesn’t seem to be compatible with the “historical NDC
> format” codes used in APAC.
> 
> ~  
> Benjamin Chan, MS, Research Associate
