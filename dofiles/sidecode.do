clear
cd "C:/Users/gauta/Documents/GitHub/pandemic/Data/stockdata/DataStream/data"
import delimited "stock_ts.csv",  clear
encode index, gen(index1)
xtset index1 


*generating WHO crash - can adjust this for loop in the future to generate % drop in week of first case, etc. 
gen baseyear = 1 if week == "10/01/2020"
encode week, gen(week1)
format week1 %d

levelsof index
foreach i in index(levels) {
    gen rel_closingprice = 1 if baseyear == 1
    replace rel_closingprice = closingprice/closingprice[_n-1] if baseyear != 1
	
}


export delimited stock_ts2.csv, replace

//https://www.kaggle.com/imdevskp/h1n1-swine-flu-2009-pandemic-dataset
cd "C:/Users/gauta/Documents/GitHub/pandemic/Data/Other"
import delimited "h1n1.csv", clear
order country cumul_cases cumul_deaths date
rename country Country
encode Country, gen(id)
encode date, gen(dateid)

xtset id dateid
egen max_cases =  max(cumul_cases), by(id)
keep id Country max_cases
gen y = 1 if max_cases == max_cases[_n-1]
drop if y == 1
drop y

merge 1:1 Country using "C:/Users/gauta/Documents/GitHub/pandemic/Data/Xvar/master_X"
//next: drop duplicates by getting rid of all vars except country and max cases, then finding out how to drop duplicates. Then merge with World Bank data (both Xvars), and draw some plots/run regression. 
//then download economic growth data, and add to the regression, then generate hospital bed growth rate after h1n1 as a independent var.
save h1n1_1.dta, replace


*adding health expenditure data to the above dataset.

keep Country id max_cases _merge WB_hb_p1000 WHO_2018


*graphing - dropping a value here, so reinstate it after!
set scheme plottig
drop if max_cases > 12000
drop if max_cases < 50
scatter WB_hb_p1000 max_cases, title({bf:H1N1 Cases and Hospital Beds}, size(8pt)) xtitle("H1N1 Cases") ytitle("Hospital Beds/1000 (most recent value)") legend(off) || lfit  WB_hb_p1000 max_cases, lcolor(black)

scatter WHO_2018 max_cases, title({bf:H1N1 Cases and Health Expenditure}, size(8pt)) xtitle("H1N1 Cases") ytitle("2018 Health Expenditure (% of GDP)") legend(off) || lfit  WHO_2018 max_cases, lcolor(black)


use h1n1_1.dta, clear
asdoc regress WB_hb_p1000 max_cases, robust replace dec(5)
asdoc regress WHO_2018 max_cases, robust replace dec(5)

*gen the other thing - rate of increase. regress and graph. then do the first thing (aggregate by continent.) Then make a doc.

* Rate of Increase
import excel "C:/Users/gauta/Documents/GitHub/pandemic/Data/Xvar/WB_Hosp_Beds_p1000.xlsx", sheet("Table2") firstrow clear
encode CountryName, gen(id)
rename Attribute Year
encode Year, gen(Yearid)
rename Value WB_hb_p1000
xtset id Yearid

drop if Year != inlist("2010" "2011" "2012" "2013" "2014" "2015")