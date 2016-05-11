# Read Oregon Medicaid Fee Schedules

Main website for OHP Data and Reports is [here](http://www.oregon.gov/oha/healthplan/Pages/reports.aspx).
The website for fee schedules is [here](http://www.oregon.gov/oha/healthplan/Pages/feeschedule.aspx).
File specification is [here](http://www.oregon.gov/oha/healthplan/tools/File%20specifications%20for%20DMAP%20fee-for-service%20fee%20schedule.pdf).

* Fee schedule are release quarterly
* Oregon's Medicaid fee schedules come in either CSV, PDF, or Excel format; we'll download the CSV versions
* File name format is in the form
    `http://www.oregon.gov/oha/healthplan/DataReportsDocs/[monthname]%20YYYY%20Fee%20Schedule%20-%20CSV.csv`  
    `monthname` is generally Februrary, May, August, November; but is not consistent.
    **Manual checking at the OHP fee schedules [website](http://www.oregon.gov/oha/healthplan/Pages/feeschedule.aspx) is required.**
* `report_date` is not exact
    It is parsed from the URL and uses the 1st of the month
    It is not the actual date of the fee schedule report posted on the fee schedules [website](http://www.oregon.gov/oha/healthplan/Pages/feeschedule.aspx)
    
See the Jupyter notebook [readFeeSchedule.ipynb](https://github.com/chse-ohsu/PublicUseData/blob/master/MedicaidFeeSchedules/OR/readFeeSchedule.ipynb).
