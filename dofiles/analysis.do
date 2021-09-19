clear
cd "C:/Users/gauta/Documents/GitHub/pandemic"
capture log close
log using "pandemic.log", replace

*Analysis 1: Regressing GHSI_Overall on stock_1/stock_WHO2 (daily stock data from Investing.com). (12/09/21)
use "./Data/pandemic.dta", clear
keep Country stock_1 stock_WHO2 GHSI_Overall
drop if stock_WHO2 ==.

scatter stock_1 GHSI_Overall
scatter stock_WHO2 GHSI_Overall

asdoc reg stock_1 GHSI_Overall, robust
asdoc reg stock_WHO2 GHSI_Overall, robust

*Analysis 2: Regressing GHSI_Overall on Weekly Stock data from Datastream (different sample of countries).

log close
