clear
cd "C:/Users/gauta/Documents/GitHub/pandemic"
capture log close
log using "graphing.log", replace

//generate bar charts of Hospital Beds/1000
use "./Data/pandemic_master.dta", clear
keep Country id dstr_WHO dstr_WHO2 WB_hb_p1000
drop if dstr_WHO ==.
drop if WB_hb_p1000==.

set scheme plottig
graph bar WB_hb_p1000, over(id, sort(1) label(angle(90))) title({bf: Hospital Beds per 1000:} {it: A Cross-Country Comparison}, size(8pt)) ytitle("Hospital Beds per 1000")

graph save "C:/Users/gauta/Documents/GitHub/pandemic/figures/xvars/pres_bar_1.gph", replace

//generate bar charts of Health Expenditure as % of GDP
use "./Data/pandemic_master.dta", clear
keep Country id dstr_WHO dstr_WHO2 WHO_2018_HE_GDP
drop if dstr_WHO ==.
drop if WHO_2018_HE_GDP==.

set scheme plottig
graph bar WHO_2018_HE_GDP, over(id, sort(1) label(angle(90))) title({bf: Health Expenditure as % of GDP:} {it: A Cross-Country Comparison}, size(8pt)) ytitle("Health Expenditure (% of GDP)")

graph save "C:/Users/gauta/Documents/GitHub/pandemic/figures/xvars/pres_bar_2.gph", replace