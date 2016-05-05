# Read Washington Medicaid Fee Schedules

The Washington state Health Care Authority website for fee schedules is [here](http://www.hca.wa.gov/medicaid/rbrvs/Pages/index.aspx).

* Fee schedules come in Excel format
* Fee schedules are *usually* biannual (January and July)
* Publicly available fee schedules go back to January 2011

However, Washington's Medicaid fee schedules are a pain in the ass.
They are publicly available as Microsoft Excel files but...

* File names are not systematic
* They do not read directly into R nicely (using either the `readxl` or `xlsx` packages)
* Data lines start at different rows

All these issues makes codifying difficult.
As a workaround, the following steps were taken.

1. Excel files are saved locally
2. Excel files are converted to CSV
3. CSV files are version controlled in this repository (since they are not large)
4. CSV files are read into R

The first 3 steps were done manually.
The SHA for the commit of the CSV files is 5bde7f3e33e0c83bdace0ed0cf04553a41a8efb1 (5/5/2016).
Step 4 is in the Jupyter Notebook, [readFeeSchedule.ipynb](readFeeSchedule.ipynb)
