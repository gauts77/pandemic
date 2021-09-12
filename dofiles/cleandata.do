//inspect 

clear
cd "C:/Users/gauta/Documents/GitHub/pandemic"

//cleaning/renaming ghsi data
import excel "./data/GHSI_2019_data.xlsx", sheet("Sheet2") firstrow clear
drop J K L M N O P Q R S T U

rename Overall GHSI_Overall
rename D GHSI_prev
rename E GHSI_det
rename F GHSI_resp
rename G GHSI_hea_sec
rename H GHSI_commit
rename I GHSI_risk

save ghsi.dta, replace

//looking for outliers/inspecting data
sum 
inspect 

//todo: download subsample of stock market data when the pandemic hit. 
	//first, download time series stock market excel sheets for Jan/Feb/March/April each country. Have this dataset available (so that we can edit the lags if needed in next step) - DONE
		//then cut in STATA - for each country, 4 variables: stock market performance on the day it hit, 1 week, 2 weeks and 1 month after. Dates: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7068164/
			//then merge into GHSI data.
	
	//pandemic timeline: do a variable of stock returns following: WHO pandemic announcement (11th March) + 2 day and 1 week lags. For lags - do average of daily fluctuations or? Probably. Could do sum of variation (don't think this would have an effect).
	//then also do 1st case in country + lags.
	
//regression: % change_i = a + bGHSI_i + u_i. No control variables yet; dependent variable varies depending on dates.
