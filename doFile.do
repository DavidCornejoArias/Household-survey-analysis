import excel "C:\Users\david\Dropbox\RA application\Classwork and other interships\More statistical code\town_names.xlsx", sheet("Sheet1") firstrow clear
*rename TownID town_id
save "C:\Users\david\Dropbox\RA application\Classwork and other interships\More statistical code\towns.dta", replace
import excel "C:\Users\david\Dropbox\RA application\Classwork and other interships\More statistical code\data.xlsx", sheet("Sheet1") firstrow clear
merge m:1 town_id using "C:\Users\david\Dropbox\RA application\Classwork and other interships\More statistical code\towns.dta"
destring district, generate(district_numeric)
* eliminating data that is not needed
drop if registered_female == - 999| registered_female == -998
* Creating dummies for each city
tabulate town_id, generate(town)
* Average total turn out rate, highes and lowest, how many recorded the highest turn out rate
gen  turnout_total_rate = turnout_total/ registered_total
summarize turnout_total_rate
by treatment_phase, sort : tabulate treatment
*Tabulate average turn out rate for female which have a higher that 75%
gen  turnout_female_rate = turnout_female/ registered_female
mean turnout_female_rate if turnout_female_rate>0.75
*Regression
regress turnout_female town_id turnout_total treatment
*improve version
regress turnout_female registered_total town_id turnout_total treatment
*mean total turn out right for the control group
mean turnout_female_rate if treatment==0
