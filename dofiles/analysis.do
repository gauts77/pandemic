clear
cd "C:/Users/gauta/Documents/GitHub/pandemic"
capture log close
log using "pandemic.log", replace

*Analysis 1: stock_1/stock_WHO2 ~ GHSI_Overall (12/09/21)
use "./Data/pandemic.dta", clear
keep Country stock_1 stock_WHO2 GHSI_Overall
drop if stock_WHO2 ==.

scatter stock_1 GHSI_Overall
scatter stock_WHO2 GHSI_Overall

asdoc reg stock_1 GHSI_Overall, robust
asdoc reg stock_WHO2 GHSI_Overall, robust

*Analysis 2: dstr_WHO ~ GHSI_Overall (19/09/21)
use "./Data/pandemic.dta", clear
keep Country dstr_WHO GHSI_Overall 
scatter dstr_WHO GHSI_Overall

asdoc reg dstr_WHO GHSI_Overall, robust replace dec(5)

*Analysis 3: stock_1/stock_WHO2 ~ WHO_ACHB (20/09/21)
use "./Data/pandemic_master.dta", clear
keep Country stock_1 stock_WHO2 WHO_ACHB_p100k

scatter stock_1 WHO_ACHB_p100k
scatter stock_WHO2 WHO_ACHB_p100k

//regressions: n is very low. Haven't downloaded a lot of stock data (18/24 countries), and the ACHB data only covers 51 countries.
reg stock_1 WHO_ACHB_p100k //n = 9. Positive and insignificant.
reg stock_WHO2 WHO_ACHB_p100k //n = 11. Negative and insignificant

*Analysis 4: dstr_WHO ~ WHO_ACHB
use "./Data/pandemic_master.dta", clear
keep Country dstr_WHO WHO_ACHB_p100k

scatter dstr_WHO WHO_ACHB_p100k // looks like it could be a positive correlation?

reg dstr_WHO WHO_ACHB_p100k //n = 12, positive insignificant.

log close

//Sample sizes are way too small atm. Especially analysis #4 looks like it could very well be a positive correlation, but n is way too small.