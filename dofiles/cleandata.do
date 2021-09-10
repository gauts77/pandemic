//inspect 

clear
cd "C:/Users/gauta/Documents/GitHub/pandemic"

//open dataset
import excel "./data/GHSI_2019_data.xlsx", sheet("Sheet2") firstrow clear
drop J K L M N O P Q R S T U

rename Overall GHSI_Overall
rename D GHSI_prev
rename E GHSI_det
rename F GHSI_resp
rename G GHSI_hea_sec
rename H GHSI_commit
rename I GHSI_risk

