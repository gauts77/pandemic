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
