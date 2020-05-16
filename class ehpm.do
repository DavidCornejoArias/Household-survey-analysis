
local EHPM2018 = "C:\Users\david\Dropbox\RA application\Classwork and other interships\Stata\EHPM2018.dta"
use "`EHPM2018'",clear
*Population according to type of area
tabulate area [w=fac00]
*People education level
tabulate r215a if r106>24 [w=fac00]
*Woman education level
tabulate r215a if r106>24 & r104==2 [w=fac00]
*Small graphics
tabulate r215a if r106>24 & r104==2 [w=fac00], plot
*Households by area
tabulate area if r103 ==1 [w=fac00]

*Poor population by area type
tabulate pobreza area [w=fac00], nofreq column
*Poor population percentage by area type
tabulate pobreza area [w=fac00], nofreq row
*Poor households by area type
tabulate pobreza area if r103==1 [w=fac00], nofreq row
* Income distribution
summarize ingpe [w=fac00]
* Understanding income by household
summarize ingfa if r103 == 1 [w=fac00]

*comparing income by genre
ttest money, by(r104)
tabulate r215a if r106>24 [w=fac00]
ttest money if r215a==4, by(r104)

*Variable received or not remittances
gen remesa = 0 if r703 == 5
replace remesa = 1 if r703 !=5 & r703 !=.
label var remesa "si el hogar recibe remsa"
label def remesa 1"recibe" 0"no recibe"
label val remesa remesa

*General poverty
gen pobreza2 = 0 if pobreza == 3
replace pobreza2 = 1 if pobreza !=3 & pobreza !=.
label var pobreza2 "If the household is poor"
label def pobreza2 1"Poor household" 0"No poor household"
label val pobreza2 pobreza2

*T-test with new variables created
ttest pobreza2 if r103==1, by(remesa)

*Regressions
regress money r104 aproba1 r106 area if r106>18 & actpr2012 ==10 [w=fac00]
*Graphics
twoway (scatter ingfa gastohog) if r103 ==1 & ingfa<1000 & gastohog <1000 & area==0
twoway (scatter money aproba1) if r103 ==1 & money<1000 & gastohog <1000 & area==0
