clear
cd "C:/Users/gauta/Documents/GitHub/pandemic/Data/Xvar"


*X Variables
//GHSI DATA (X1a)
import excel "./GHSI_2019_data.xlsx", sheet("Sheet2") firstrow clear
drop J K L M N O P Q R S T U

rename Overall GHSI_Overall
rename D GHSI_prev
rename E GHSI_det
rename F GHSI_resp
rename G GHSI_hea_sec
rename H GHSI_commit
rename I GHSI_risk

save ghsi.dta, replace

*Acute Care Hospital Beds (X1b)

import excel "./WHO_ACHB.xlsx", firstrow clear
encode COUNTRY, gen(panel_id)
drop if panel_id ==.
xtset panel_id YEAR
kountry COUNTRY, from(iso3c)
rename NAMES_STD Country
rename VALUE WHO_ACHB_p100k
rename YEAR Year
keep Country panel_id Year WHO_ACHB_p100k


//generating cross-section of most recent value
bysort panel_id(Year) : gen diff = panel_id != panel_id[_n+1]
drop if diff != 1
drop if Year ==.
save WHO_ACHB.dta, replace

drop panel_id diff Year
merge 1:1 Country using "C:/Users/gauta/Documents/GitHub/pandemic/Data/Xvar/ghsi.dta"
drop _merge
save master_X, replace

//-----------------------------------------------------------------------------

//STOCK MARKET DATA (Y)
cd "C:/Users/gauta/Documents/GitHub/pandemic/Data/stockdata"

*stock market data from Investing.com
import excel "stockfluctuations_1.xlsx", firstrow clear
save inv_fluctuations.dta, replace

*Datastream data - For Loop generating % change between 06/03 and 13/03
import excel "DataStream/data/stock_ts.xlsx", sheet(Table1) firstrow clear

*generating WHO crash - can adjust this for loop in the future to generate % drop in week of first case, etc. 
keep Country K L
foreach i in Country {
	gen dstr_WHO = ((L - K)/K)
	}

drop K L
save dtsr_fluctuations.dta, replace

*saving master stock fluctuations file
merge 1:1 Country using inv_fluctuations.dta
drop _merge
save master_Y.dta, replace

*merging master Y and X data
merge 1:1 Country using "C:/Users/gauta/Documents/GitHub/pandemic/Data/Xvar/master_X.dta"
save "C:/Users/gauta/Documents/GitHub/pandemic/Data/pandemic_master.dta", replace






















//only downloaded/merged x and y thus far, for a subsample of countries. No control variables yet.

//todo: download subsample of stock market data when the pandemic hit. 
	//first, download time series stock market excel sheets for Jan/Feb/March/April each country. Have this dataset available (so that we can edit the lags if needed in next step) - DONE
		//then cut in STATA - for each country, 4 variables: stock market performance on the day it hit, 1 week, 2 weeks and 1 month after. Dates: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7068164/
			//then merge into GHSI data.
	
	//pandemic timeline: do a variable of stock returns following: WHO pandemic announcement (11th March) + 2 day and 1 week lags. For lags - do average of daily fluctuations or? Probably. Could do sum of variation (don't think this would have an effect).
	//then also do 1st case in country + lags.
	
//regression: % change_i = a + bGHSI_i + u_i. No control variables yet; dependent variable varies depending on dates.
