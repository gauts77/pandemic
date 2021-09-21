clear
cd "C:/Users/gauta/Documents/GitHub/pandemic"
capture log close
log using "pandemic.log", replace

*Analysis 1: stock_1/stock_WHO2 ~ GHSI_Overall (12/09/21)
use "./Data/pandemic_master.dta", clear
keep Country inv_stock_1 inv_stock_WHO2 GHSI_Overall

scatter inv_stock_1 GHSI_Overall || lfit inv_stock_1 GHSI_Overall
scatter inv_stock_WHO2 GHSI_Overall ||lfit inv_stock_WHO2 GHSI_Overall

asdoc reg inv_stock_1 GHSI_Overall, robust
asdoc reg inv_stock_WHO2 GHSI_Overall, robust

*Analysis 2: dstr_WHO ~ GHSI_Overall (19/09/21)
use "./Data/pandemic_master.dta", clear
keep Country dstr_WHO GHSI_Overall 
scatter dstr_WHO GHSI_Overall || lfit dstr_WHO GHSI_Overall, xtitle("GHSI") ytitle("dstr_WHO")

asdoc reg dstr_WHO GHSI_Overall, robust replace dec(5)

*Analysis 3: stock_1/stock_WHO2 ~ WHO_ACHB (20/09/21)
use "./Data/pandemic_master.dta", clear
keep Country inv_stock_1 inv_stock_WHO2 WHO_ACHB_p100k

scatter inv_stock_1 WHO_ACHB_p100k || lfit inv_stock_1 WHO_ACHB_p100k, xtitle("ACHB per 100,000") ytitle("Stock Fluctuation on" "Day of 1st Case")
scatter inv_stock_WHO2 WHO_ACHB_p100k || lfit inv_stock_WHO2 WHO_ACHB_p100k, xtitle("ACHB per 100,000") ytitle("Stock Fluctuation on 12th March")

//regressions: n is very low. Haven't downloaded a lot of stock data (18/24 countries), and the ACHB data only covers 51 countries.
reg inv_stock_1 WHO_ACHB_p100k //n = 9. Positive and insignificant.
asdoc reg inv_stock_WHO2 WHO_ACHB_p100k, robust replace dec(5) //n = 11. Negative and insignificant

*Analysis 4: dstr_WHO ~ WHO_ACHB
use "./Data/pandemic_master.dta", clear
keep Country dstr_WHO WHO_ACHB_p100k

scatter dstr_WHO WHO_ACHB_p100k|| lfit dstr_WHO WHO_ACHB_p100k, xtitle("ACHB per 100,000") ytitle("Stock Fluctuation between" "06/03/20 and 13/03/20")

asdoc reg dstr_WHO WHO_ACHB_p100k, robust replace dec(5) //n = 12, positive insignificant.

log close

//todo: set up a loop to save graphs more systematically.