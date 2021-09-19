clear
cd "C:/Users/gauta/Documents/GitHub/pandemic/Data"

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

*here - when working with other potential explanatorys, create a master X file

//looking for outliers/inspecting data
sum 
inspect 

//STOCK MARKET DATA (Y)

*stock market data from Investing.com
import excel "./stockdata/stockfluctuations_1.xlsx", firstrow clear
save inv_fluctuations.dta, replace

*Datastream data - For Loop generating % change between 06/03 and 13/03
import excel "./stockdata/DataStream/data/stock_ts.xlsx", sheet(Table1) firstrow clear

*generating WHO crash - can adjust this for loop in the future to generate % drop in week of first case, etc. 
keep Country K L
foreach i in Country {
	gen dstr_WHO = ((L - K)/K)
	}

drop K L
save dtsr_fluctuations.dta, replace

*saving master stock fluctuations file
merge 1:1 Country using inv_fluctuations.dta
drop if _merge !=3
drop _merge
save master_fluctuations.dta, replace

*merging master stock and GHSI data
merge 1:1 Country using ghsi.dta
drop if _merge !=3
drop _merge
save pandemic.dta, replace




















//only downloaded/merged x and y thus far, for a subsample of countries. No control variables yet.

//todo: download subsample of stock market data when the pandemic hit. 
	//first, download time series stock market excel sheets for Jan/Feb/March/April each country. Have this dataset available (so that we can edit the lags if needed in next step) - DONE
		//then cut in STATA - for each country, 4 variables: stock market performance on the day it hit, 1 week, 2 weeks and 1 month after. Dates: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7068164/
			//then merge into GHSI data.
	
	//pandemic timeline: do a variable of stock returns following: WHO pandemic announcement (11th March) + 2 day and 1 week lags. For lags - do average of daily fluctuations or? Probably. Could do sum of variation (don't think this would have an effect).
	//then also do 1st case in country + lags.
	
//regression: % change_i = a + bGHSI_i + u_i. No control variables yet; dependent variable varies depending on dates.
