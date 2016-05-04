Colorado's Medicaid fee schedules are a pain in the ass.
They are publicly available as Microsoft Excel files but...

* File names are not systematic
* File formats are not uniform (`.xls` and `.xlsx`)
* They read in directly into R nicely (using either the `readxl` or `xlsx` packages)

All these issues makes codifying difficult.

As a workaround

* Excel files are saved locally
* Excel files are converted to CSV
* CSV files are version controlled in this repository (since they are not large)
* CSV files are read
