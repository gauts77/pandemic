clear
cd "C:/Users/gauta/Documents/GitHub/pandemic"
capture log close
log using "pandemic.log", replace

*initial analysis - 12/09/21 (GHSI_Overall and stock_1/stock_WHO2)
use "./Data/pandemic.dta", clear
keep Country stock_1 stock_WHO2 GHSI_Overall
drop if stock_WHO2 ==.

scatter stock_1 GHSI_Overall
scatter stock_WHO2 GHSI_Overall

asdoc reg stock_1 GHSI_Overall, robust
asdoc reg stock_WHO2 GHSI_Overall, robust

log close
