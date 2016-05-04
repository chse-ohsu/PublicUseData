# Read Colorado Medicaid Fee Schedules

The Colorado Department of Health Care Policy and Financing (HCPF) website for fee schedules is [here](https://www.colorado.gov/pacific/hcpf/provider-rates-fee-schedule).

* Fee schedules come in Excel format
* Fee schedules are biannual (January and July)
* Publicly available fee schedules go back to January 2012
* Fee schedule instructions are also available; instructions for January 2015 are linked [here](https://www.colorado.gov/pacific/sites/default/files/Fee%20schedule%20instructions%20January%202015.pdf)

However, Colorado's Medicaid fee schedules are a pain in the ass.
They are publicly available as Microsoft Excel files but...

* File names are not systematic
* File formats are not uniform (`.xls` and `.xlsx`)
* They do not read directly into R nicely (using either the `readxl` or `xlsx` packages)

All these issues makes codifying difficult.
As a workaround, the following steps were taken.

1. Excel files are saved locally
2. Excel files are converted to CSV
3. CSV files are version controlled in this repository (since they are not large)
4. CSV files are read into R

The first 3 steps were done manually.
The SHA for the commit of the CSV files is `bfbbd07a2d538ec57e61cddf3616993aa74b78b1` (5/4/2016).
Step 4 is in the Jupyter Notebook, [readFeeSchedule.ipynb](readFeeSchedule.ipynb)
