*  Clearing Memory 
*********************************************** 

        clear all                        // clear memory
        set more off                     // For the output not to pause after each page
		cls                              // clear console

* unique identifiers, children: CASEID V001 V002 V003 BIDX



 *  Set Working Directory / Dynamic Path
***********************************************

*   Note: Change the main folder according to it's location in the host computer 

global folder "C:/Users/Andy/Downloads/Thesis_Stata_Do_Files" 
global output "${folder}/output" 
global script "${folder}/dofile" 
global data "${folder}/data" 
global final "${data}/final"   
global mypath "${data}/ETH_DHS_all"     // 
global dhs19  "${data}/ETH_DHS_all/DHS2019/ETKR81DT"
global KR16 "${mypath}/ETKR71DT"     // Ethiopia birth record data 2016
global KR11 "${mypath}/ETKR61DT"     // Ethiopia birth record data 2011
global KR05 "${mypath}/ETKR51DT"     // Ethiopia birth record data 2005
global KR00 "${mypath}/ETKR41DT"     // Ethiopia birth record data 2000



****************************************************************
use "${dhs19}/ETKR81FL.DTA", clear // open 2016 BR data

count // count the number of observations in the dataset
codebook caseid // unique identifier

// rename variables:
rename v006 monthint
rename v007 intyear
rename v016 intdate
* change ethiopian calender to gregorian YEAR
replace intyear = 2019 if intyear == 2011

// 2019 KR file has no ethnicity information

*standardsie region varaible v101 to harmonize with other rounds
replace v101  =  15 if v101  == 11 //DD
replace v101  =  14 if v101  == 10 // AA
replace v101  =  13 if v101  == 9  // Harari
replace v101  =  12 if v101  == 8  // gambela

* label regions
label define region_lab 1 "Tigray" 2 "Affar" 3 "Amhara" 4 "Oromiya" 5 "Somali" 6 "Benishangul-Gumuz" 7 "SNNP" 12 "Gambela" 13 "Harari" 14 "Addis Ababa" 15 "Dire Dawa"
label values v101 region_lab

// Save clean data 2016 birth recode
save "${KR16}/cleankr19.dta", replace     // save clean data



*******************************************************************************
use "${KR16}/ETKR71FL.DTA", clear // open 2016 BR data
count // count the number of observations in the dataset
codebook caseid // unique identifier

// rename variables:
rename v006 monthint
rename v007 intyear
rename v016 intdate
* change ethiopian calender to gregorian YEAR
replace intyear = 2016 if intyear == 2008
rename v131 ethnic  // ethnicity

*drop if ethnic == 96  // others
*drop if ethnic == 93  // foreign
*drop if ethnic == 99  // missing


replace ethnic =  1 if ethnic == 4 // afar
replace ethnic = 4 if ethnic == 1 // Amhara
replace ethnic = 25 if ethnic == 6 // gurage
replace ethnic = 60 if ethnic == 2  // oromo
replace ethnic = 67 if ethnic == 7 //sidama
replace ethnic = 68 if ethnic == 5 // somalie
replace ethnic = 70 if ethnic == 3 // Tigray
replace ethnic = 72 if ethnic == 9 // welaita
replace ethnic = 96 if !inlist(ethnic, 1, 4, 25, 60, 67, 68, 70, 72) //others

* label define and value ethnic categories
label define ethnic_label 1 "Afar" 4 "Amhara" 25 "Guragie" 60 "Oromo" 67 "Sidama" 68 "Somalie" 70 "Tigray" 72 "Welaita"  96 "Other" 
label values ethnic ethnic_label

*standardsie region varaible v101 to harmonize with other rounds
replace v101  =  15 if v101  == 11 //DD
replace v101  =  14 if v101  == 10 // AA
replace v101  =  13 if v101  == 9  // Harari
replace v101  =  12 if v101  == 8  // gambela

* label regions
label define region_lab 1 "Tigray" 2 "Affar" 3 "Amhara" 4 "Oromiya" 5 "Somali" 6 "Benishangul-Gumuz" 7 "SNNP" 12 "Gambela" 13 "Harari" 14 "Addis Ababa" 15 "Dire Dawa"
label values v101 region_lab

// Save clean data 2016 birth recode
save "${KR16}/cleankr16.dta", replace     // save clean data
******************************************************************************

*Children recode 2011
**************************************************************************

        clear all                        // clear memory
		cls                              // clear console



use "${KR11}/ETKR61FL.DTA", clear // open 2011 BR data
count // count the number of observations in the dataset
codebook caseid // unique identifier 

* rename
rename v131 ethnic
rename v006 monthint
rename v007 intyear
rename v016 intdate
replace intyear = 2011 if intyear == 2003  




// standardise ethnicity names
replace ethnic =  1 if ethnic == 1 
replace ethnic = 4 if ethnic == 5
replace ethnic = 25 if ethnic == 35
replace ethnic = 60 if ethnic == 66
replace ethnic = 67 if ethnic == 74
replace ethnic = 68 if ethnic == 76
replace ethnic = 70 if ethnic == 79
replace ethnic = 72 if ethnic == 83
replace ethnic = 96 if !inlist(ethnic, 1, 4, 25, 60, 67, 68, 70, 72)

* label define and value ethnic categories
label define ethnic_label 1 "Afar" 4 "Amhara" 25 "Guragie" 60 "Oromo" 67 "Sidama" 68 "Somalie" 70 "Tigray" 72 "Welaita"  96 "Other" 
label values ethnic ethnic_label


// Save clean data 2011 birth recode
save "${KR11}/cleankr11.dta", replace     // save clean data


*******************************************************************************
* Children recode 2005
*******************************************************************************
       clear all                        // clear memory
		cls                              // clear console
		
use "${KR05}/ETKR51FL.DTA", clear // open 2005 BR data
count // count the number of observations in the dataset
codebook caseid // unique identifier     

// rename variables:
rename v006 monthint
rename v007 intyear
rename v016 intdate

* change ethiopian calender to gregorian YEAR
replace intyear = 2005 if intyear == 1997  
rename v131 ethnic

* drop foreign citizens and others
* drop if inlist(ethnic, 96,97,98)

* replace southern ethnicities as others
replace ethnic = 96 if !inlist(ethnic, 1, 4, 25, 60, 67, 68, 70, 72)

* label define and value ethnic categories
label define ethnic_label 1 "Afar" 4 "Amhara" 25 "Guragie" 60 "Oromo" 67 "Sidama" 68 "Somalie" 70 "Tigray" 72 "Welaita"  96 "Other" 
label values ethnic ethnic_label
	
// Save clean data 2011 birth recode
save "${KR05}/cleankr05.dta", replace     // save clean data

******************************************************************************



**************************************************************************
* Children recode 2000
**************************************************************************

        clear all                        // clear memory
		cls                              // clear console
		
use "${KR00}/ETKR41FL.DTA", clear // open 2000 BR data
count // count the number of observations in the dataset
codebook caseid // unique identifier     

// rename variables:
rename v006 monthint
rename v007 intyear
rename v016 intdate

* change ethiopian calender to gregorian YEAR
replace intyear = 2000 

// Select relevant variables
//keep caseid-intdate v104-v153 bord-b9 v190-v191a
rename v131 ethnic


* replace southern ethnicities as others
replace ethnic = 96 if !inlist(ethnic, 1, 4, 25, 60, 67, 68, 70, 72)

* label define and value ethnic categories
label define ethnic_label 1 "Afar" 4 "Amhara" 25 "Guragie" 60 "Oromo" 67 "Sidama" 68 "Somalie" 70 "Tigray" 72 "Welaita"  96 "Other" 
label values ethnic ethnic_label

// Save clean data 2000 birth recode
save "${KR00}/cleankr00.dta", replace     // save clean data


*******************************************************************************

*Append children recode 2000, 2005, 2011, 2016

*******************************************************************************
* Open 2000 kR data
use  "${KR00}/cleankr00.DTA", clear

* append with 2005 BR data
append using "${KR05}/cleankr05.DTA", force

* append 2011 kR data
append using "${KR11}/cleankr11.DTA", force

* append with 2016 kR data
append using "${KR16}/cleankr16.DTA", force


append using "${KR16}/cleankr19.DTA", force

* drop unesscary variables - caseid-intdate v104-v153 bord-b9 s475c-sm508va
* drop s475c-sm508va

* save merged BR data set
save "${KR16}/all_KR_raw.dta", replace     // save merged data




*****************************************************************************************************
*              
*                                creating varaibles
*
*****************************************************************************************************



// all merged raw data BR
use "${KR16}/all_KR_raw.dta", clear



// important WORK on the APPENDING, THE CURRENT IS NOT RIGHT. KEEP VARIABLES
// convert kid birth year to gregorian


gen kbyear = 8+b2
lab var kbyear "kid birth year"
// convert mom birth year to gregorian

gen mombyear = 8+v010
label variable mombyear "mother birth year"

* generate mom age when the child was born
gen momage = v012 - (intyear-kbyear)

* program effect
*********************************************

* Coethnic by mothers ethnicity
gen coethnic = 0
label var coethnic "Coethnicity with leaders"
replace coethnic = 1 if ethnic == 70 & kbyear >= 1991 // Tigray coethnicty

// under five mortality rate
gen cmr = 0
replace cmr = 1 if  b7 <= 60
label var cmr "under fixe mortality rate"

// coethnicity during the hsdp
gen hsdp = 0
replace hsdp = 1 if ethnic ==70 & kbyear >= 1998 

* coethnic during the HEP
* keep if kid_b_year >= 2006
gen hep = 0
replace hep = 1 if ethnic ==70 & kbyear >= 2004

* Coethnic during the HEP
* keep if kid_b_year >= 2011
gen hda = 0
replace hda = 1 if ethnic == 70 & kbyear >= 2012


***********************************************************
*CHILD HEALTH
***********************************************************

gen infant = 0
label var infant "Infant mortality"
rename b5 childalive
rename b6 childagedeath
replace infant = 1 if childalive == 0 & childagedeath <= 212

* construct Neonatal mortality
gen neonat = 0
label var neonat "neonatal mortality"
replace neonat = 1 if childalive == 0 & childagedeath <= 128

********************************************************************************
* Construct infant survival variable
********************************************************************************
gen infant_survival = 0
label var infant_survival "Infant survival"
replace infant_survival = 1 - infant

sum infant_survival


gen KidFemale = .
replace KidFemale = 1 if b4 == 2
replace KidFemale = 0 if b4 == 1
lab var KidFemale "Female"

/* Generate decade variable */
gen decade = floor(kbyear/10)*10

/* Tabulate by decade and infant mortality */
table decade infant 
/* Add row and column totals */

* missing values
gen electricity = v119
replace electricity = . if electricity == 7 // non residence as missing values
replace electricity = . if electricity == 9 // non residence as missing values

gen residence = v140
replace residence = . if v140 == 7 // non residence as missing values
replace residence = 0 if v140 == 1
replace residence = 1 if v140 == 2
lab var residence "residence"

gen wealth = v190
lab var wealth "wealth index"

// mom education
gen momedu = v106
replace momedu = 1 if v106 == 2
replace momedu = 1 if v106 == 3
replace momedu = 0 if v106 == 1
replace momedu = 0 if v106 == 0
lab var momedu "mother's education"



/* Generate birth year categories */
// there was also border war 
// plus 1998 +2 years for hsdp efffects unfolding
gen century = .
replace century = 1 if kbyear >= 2000
replace century = 0 if kbyear <= 2000
lab var century "birth after 2000"

* institutional delivery
gen facdel = 0
replace facdel = 1 if inlist(m15, 20, 21, 22, 23, 24, 26, 30, 31, 32, 33, 36)
replace facdel= 0 if inlist(m15, 11, 10, 12, 13, 41, 46, 96)
replace facdel = . if m15 == 99
lab var facdel "facility delivery"

* assisted by a doctor
gen  assistdoc = .
replace assistdoc = 1 if inlist(m3a, 1)
replace assistdoc = 0 if inlist(m3a, 0)
replace  assistdoc = . if m3a == 9
lab var assistdoc "Birth assisted by Doctor"


* create binary twin variable
gen twin = 0
replace twin = 1 if b0 != 0
lab var twin "twin"


gen dataset = "full"


save "${KR16}/analysis_ready_kr.dta", replace     // save merged data

****************************************************
*
* Create separate data for urban and rural 
*
****************************************************

use "${KR16}/analysis_ready_kr.dta", clear // open the data
// Create a new variable to indicate urban or rural
gen urban = (v140 == 1)
gen rural = (v140 == 2)

// Save rural data to a new file
preserve
keep if rural
replace dataset = "rural"
save "${KR16}/analysis_rural.dta", replace
restore

// Save urban data to a new file
preserve
keep if urban
replace dataset = "urban"
save "${KR16}/analysis_urban.dta", replace
restore

preserve
keep if v101 == 3 | v101 == 4 | v101 == 1 | v101 == 7
replace dataset = "regions"
save "${KR16}/r_regions.dta", replace
restore

* drop unesscary variables - caseid-intdate v104-v153 bord-b9 s475c-sm508va
use "${KR16}/analysis_ready_kr.dta", clear // open the data

drop s475c-sm508va
gen weight = v005/1000000
numlabel, add

gen sqage = momage^2
lab var sqage "age squared"

gen coethcent = coethnic*century
gen coethregion = 0
replace coethregion = 1 if v101 == 1


// junior region

gen junior = 0
replace junior = 1 if  ethnic == 4 | ethnic == 60
// // senior region
gen senior = 0
replace senior = 1 if  ethnic == 70

// // senior region
gen  discriminated = 0
replace discriminated = 1 if  ethnic == 1 |  ethnic == 68 | ethnic == 67  

gen  powerless = 0
replace powerless  = 1 if  ethnic == 96 |  ethnic == 25 | ethnic == 72   


** SURVEY SET
gen psu = v021
gen strata = v023
svyset psu [pw = weight], strata(strata) vce(linearized) singleunit(scaled)
*svydes


// analysis ready data
save "${KR16}/analysis_ready_kr.dta", replace     // save merged data



*****************************************************************************************************
*              
*                                Analysis
*
*****************************************************************************************************


use "${KR16}/analysis_ready_kr.dta", clear
collapse (mean) infant neonat facdel [iw =weight], by( intyear)

table ethnic intyear, c(mean infant) missing format(%2.1f)

// place of delivery
// skilled birth attendance
// Anitenatal care 
// vaccination
// child mortality
// under-5 mortality


** sttat graph from online

bysort year treated: egen mean_gdppc = mean(gdppc)
twoway line mean_gdppc year if treated == 0, sort || ///
line mean_gdppc year if treated == 1, sort lpattern(dash) ///
legend(label(1 "Control") label(2 "Treated")) ///
xline(2009)


use "${KR16}/analysis_ready_kr.dta", clear
* Table ethnic death by coethnic decades
collapse (mean) infant neonat m15, by(ethnic intyear)
estpost table ethnic intyear,  c(mean infant) missing format(%2.1f)
eststo neonat:   estpost table ethnic intyear, by(ethnic) c(mean neonat) missing format(%2.1f) 
eststo delivery: estpost table m15 intyear, by(ethnic) c(mean m15) missing format(%2.1f)

use "${KR16}/analysis_ready_kr.dta", clear
* Table ethnic death by coethnic decades
collapse (mean) infant neonat facdel cmr assistdoc, by(v101 intyear)
eststo cmr: table v101 intyear,  c(mean cmr) missing format(%9.3f)
eststo facdel: table v101 intyear,  c(mean facdel) missing format(%9.3f)
eststo assitdoc : table v101 intyear,  c(mean assistdoc) missing format(%9.3f)
eststo assitdoc : table v101 intyear,  c(mean assistdoc) missing format(%9.3f)

use "${KR16}/analysis_ready_kr.dta", clear

* m15 can not be used in regression here. only 

* Table ethnic death by coethnic decades
collapse (mean) infant neonat m15, by(intyear)
set scheme s2color
twoway connected infant m15 neonat intyear

eststo infant: estpost tabstat ethnic intyear, columns(intyear) c(mean infant) missing format(%2.1f)
eststo neonat: estpost tabstat ethnic intyear, columns(intyear) c(mean neonat) missing format(%2.1f)
eststo delivery: estpost tabstat ethnic intyear, columns(intyear) c(mean m15) missing format(%2.1f)

*place std dev in its own column
esttab infant neonat delivery using sum_sub_stata.tex,  replace cell("mean(fmt(2)) sd(fmt(2))") nonumber nostar ///
mtitle("Full sample" "Rural" "Urban" "4 rural regions") ///
coeflabel(v012 "Mother's age" bord "Birth order" KidFemale "Female" m15 "Place of delivery" ///
m3a "Birth Assisted: Doctor" b0 "Child is twin" v140 "Residence" v130 "Religion" v119 "Electricity" v120 "Radio" ///
v121 "Television" v190 "Wealth index") ///
title(Table 4. Summary Statistics)



use "${KR16}/analysis_ready_kr.dta", clear
 ** summary statisitcs
sum infant neonat coethnic coethHSDP coethHEP coethHDA v012 bord KidFemale m15 m3a b0 v140 v130 v119 v120 v121 v190
tabstat infant neonat coethnic coethHSDP coethHEP coethHDA v012 bord KidFemale m15 m3a b0, c(stat) stat( mean sd min max n)

est clear  // clear the stored estimates
estpost tabstat infant neonat v012 bord KidFemale m15 m3a b0, c(stat) stat( mean sd min max n)
ereturn list // list the stored locals




*esttab, cells("mean sd min max count") // basic

esttab, ///
   cells("mean(fmt(%6.2fc)) sd(fmt(%6.2fc)) min max  count") nonumber ///
   nomtitle nonote noobs label collabels("Mean" "SD" "Min" "Max" "N")
   
esttab using "C:/Users/Andy/Downloads/ETH_DHS_all/table1.tex", replace ////
 cells("mean(fmt(%6.2fc)) sd(fmt(%6.2fc)) min max count") nonumber ///
  nomtitle nonote noobs label booktabs ///
  collabels("Mean" "SD" "Min" "Max" "N")
  
  
use "${KR16}/analysis_ready_kr.dta", clear
collapse (mean) m15 infant neonat [iw=weight], by( intyear)
table v101 intyear, c(mean infant) missing format(%2.1f)
table v101 intyear, c(mean m15) missing format(%2.1f)
* I do not need to m3a aissted birth because place of delivery is exaclty like m3a 
* if you give birth at a hospital your likeley to 
   
graph bar infant, over(intyear) bargap(10) intensity(70) ///
title(National infant moratlity rate per 100)  


*************************************
* chatgpt DID vesus CIC 
*************************************

// Load the data

use "${KR16}/analysis_ready_kr.dta", clear 

// Generate a dummy variable for the treatment group
gen treatment = 0
replace treamtnet = 1 if ethnic ==70

// Estimate the DiD model
reg outcome_var treatment post_treatment treatment*post_treatment

// Estimate the CIC model
reg outcome_var treatment post_treatment covariate_var treatment*covariate_var post_treatment*covariate_var


// Load the datasets

use "${KR16}/analysis_ready_kr.dta", clear
append using "${KR16}/analysis_rural.dta" 
append using "${KR16}/analysis_urban.dta" 
append using "${KR16}/r_regions.dta" 




// Use tabstat to create the summary table
tabstat infant neonat coethnic coethHSDP coethHEP coethHDA v012 bord KidFemale m15 m3a b0 v140 v130 v119 v120 v121 v190, by(dataset) stat(mean sd count)
tabstat infant neonat coethnic coethHSDP coethHEP coethHDA v012 bord KidFemale m15 m3a b0 v140 v130 v119 v120 v121 v190, by(dataset) stat(mean count) nototal format(%9.2fc)

*summary stats by subsample
eststo full: estpost summarize infant neonat coethnic coethHSDP coethHEP coethHDA v012 bord KidFemale m15 m3a b0 v140 v130 v119 v120 v121 v133 v190 if dataset=="full"
eststo rural: estpost summarize infant neonat coethnic coethHSDP coethHEP coethHDA v012 bord KidFemale m15 m3a b0 v140 v130 v119 v120 v121 if dataset=="rural"
eststo urban: estpost summarize infant neonat coethnic coethHSDP coethHEP coethHDA v012 bord KidFemale m15 m3a b0 v140 v130 v119 v120 v121 if dataset=="urban"
eststo regions: estpost summarize infant neonat coethnic coethHSDP coethHEP coethHDA v012 bord KidFemale m15 m3a b0 v140 v130 v119 v120 v121 if dataset=="regions"

*place std dev in its own column
esttab full rural urban regions using sum_sub_stata.tex,  replace cell("mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") nonumber nostar ///
mtitle("Full sample" "Rural" "Urban" "4 rural regions") ///
coeflabel(v012 "Mother's age" bord "Birth order" KidFemale "Female" m15 "Place of delivery" ///
m3a "Birth Assisted: Doctor" b0 "Child is twin" v140 "Residence" v130 "Religion" v119 "Electricity" v120 "Radio" ///
v121 "Television") ///
title(Table 4. Summary Statistics)



use "${KR16}/analysis_ready_kr.dta", clear 

 reg infant coethnic i.intyear [iw = weight], robust
 reg infant hsdp i.intyear [iw = weight], robust
 reg infant hsdp i.ethnic [iw = weight], robust
 reg infant hsdp i.ethnic [iw = weight], robust
 reg infant hep  i.ethnic [iw = weight], robust
 reg infant coethregion  i.intyear [iw = weight], robust // i.intyea b/c of differencet packages installed
 reg assistdoc coethregion  i.v101 [iw = weight], robust 
 reg facdel coethregion  i.intyear [iw = weight], robust
 reg cmr coethregion  i.intyear [iw = weight], robust

 // Robustness check
 gen amhara = 0
 replace amhara = 1 if v101 == 3
 reg cmr amhara bord, robust  // very good indicators
 
 
// under five mortality rate
  
  reg cmr coethnic bord i.kbyear, robust
  reg infant hda  i.ethnic
  reg cmr hsdp momage sqage momedu residence twin KidFemale wealth electricity bord i.kbyear [iw=weight], robust
  reg infant hsdp momage sqage momedu residence twin KidFemale wealth electricity bord i.kbyear [iw=weight], robust
  reg neonat coethnic momage sqage momedu residence KidFemale wealth electricity bord i.kbyear  [iw=weight], robust
  reg facdel hsdp momage sqage momedu residence KidFemale wealth electricity bord i.kbyear      [iw=weight], robust
  reg cmr hep momage sqage momedu residence twin KidFemale wealth electricity bord ii.kbyear    [iw=weight], robust


  reg infant hep coethcent sqage momedu residence twin KidFemale wealth electricity bord i.ethnic, robust // after 2000

  reg infant coethregion momage sqage momedu residence twin KidFemale wealth electricity bord i.v101

  replace hep = 1 if coethnic == 1 & if kbyear >=2004 
* Regression

reg infant coethnic 
reg m15 coethnic KidFemale

reg m15 v140 [iw=swt]
reg m15 v140 [iw=weight]


reg infant i.group##post2000 coethnic post2000, robust


regress infant i.coethregion##i.century [iw = weight], robust
 margins coethnic#century
regress ncigs i.state i.post 1.treat#1.post


** Or should  I focus on the hep from 2004 as an important package hsdp. as Alemu et al

reg infant hep momage sqage momedu residence twin KidFemale wealth electricity bord i.ethnic [iw=weight], robust

 // Estimate logistic regression
logit infant coethnic momage i.kbyear [iw = weight], robust

gen dhshep = 0
replace dhshep = 1 if intyear >= 2004

gen coeth_dhs_hep = 0
replace coeth_dhs_hep = 1 if coethnic*dhshep == 1

reg infant coeth_dhs_hep momage sqage momedu residence twin KidFemale wealth electricity bord i.kbyear [iw=weight], robust



// export to latex

eststo Model1: reg infant coethnic momage sqage momedu residence twin KidFemale wealth electricity bord i.kbyear [iw=weight], robust
eststo Model2: reg infant hsdp momage sqage momedu residence twin KidFemale wealth electricity bord i.kbyear [iw=weight], robust
eststo Model3: reg infant coeth_dhs_hep momage sqage momedu residence twin KidFemale wealth electricity bord i.kbyear [iw=weight], robust
eststo Model4: reg infant coeth_dhs_hep momage sqage momedu residence twin KidFemale wealth electricity bord i.kbyear [iw=weight], robust

esttab Model1 Model2 Model3 Model4 using "preliminary.tex", replace


// assited birth by a doctor DID reg
use "${KR16}/analysis_ready_kr.dta", clear 
gen assisdr_treat = 0
replace assisdr_treat = 1 if ethnic == 70

gen assisdr_year = 0
replace assisdr_year = 1 if intyear == 2016
gen treated_post = assisdr_treat*assisdr_year
 
reg assistdoc assisdr_treat assisdr_year  treated_post momedu momage i.kbyear [iw=weight], robust // this looks perfect
reg assistdoc assisdr_treat assisdr_year  treated_post momedu momage i.kbyear [iw=weight], robust // this looks perfect
reg assistdoc assisdr_treat assisdr_year  treated_post momedu momage [iw=weight], robust // this looks perfect
test treated_post
margins, dydx(treated_post)



// hep DID reg
use "${KR16}/analysis_ready_kr.dta", clear 

gen hep_treat = 0
replace hep_treat = 1 if v101 == 1

gen hep_year = 0
replace hep_year = 1 if intyear >= 2004
gen hep_treated_post = hep_treat*hep_year

reg infant hep_treat hep_year  hep_treated_post i.kbyear [iw=weight], robust // this looks perfect
test treated_post
margins, dydx(treated_post)


// hep DID reg

gen hep_treat = 0
replace hep_treat = 1 if v101 == 1

gen hep_year = 0
replace hep_year = 1 if intyear >= 2004
gen hep_treated_post = hep_treat*hep_year

reg infant hep_treat hep_year  hep_treated_post i.intyear [iw=weight], robust // this looks perfect
test hep_treated_post
margins, dydx(hep_treated_post)


// May be I can do this regress on outcome variables using the 1995 - 2016 data
//  Focusing on the two packages: 
          //                     1. 1995, 2004, 2016 (HEP/HDA)
		  //                     2. 2003, 2012, 2016 HDA or
		  //            

		  

*******************************************************************************************
*               		   HEP/HDA regression
*******************************************************************************************		  


use "${KR16}/analysis_ready_kr.dta", clear 


// hep treated -tigray from 2004
gen hep_treated = 0
replace hep_treated = 1 if ethnic == 70
drop if intyear == 2016
// hep year from 2004 to 2016
gen hep_year = 0
replace hep_year = 1 if intyear >= 2011
gen hep_treated_post = hep_treated*hep_year
 
 // the effect of hep and hda  maternal and child health (after 2006 or dhs 2011 and 2016 as treated or a kid born aft)
 // this is balance 11 year before and 11 after treatment, 2016-2006-1995

// this is interesting because the gain of other regions(imr, nmr,cmr) is higher than Tigray during hep
cls
 reg infant  hep_treated hep_year hep_treated_post momage sqage momedu residence twin KidFemale wealth  bord [iw=weight],  robust
 reg neonat  hep_treated hep_year hep_treated_post momage sqage momedu residence twin KidFemale wealth  bord [iw=weight],  robust
 reg facdel  hep_treated hep_year hep_treated_post momage sqage momedu residence twin KidFemale wealth  bord [iw=weight],  robust
 reg cmr     hep_treated hep_year hep_treated_post momage sqage momedu residence twin KidFemale wealth  bord  [iw=weight], robust
 
 //reg assistdoc  hep_treated hep_year hep_treated_post momage sqage momedu residence twin KidFemale wealth  bord [iw=weight], robust 
                      // because assistdoc is only available for 2011 and 2016 dhs rounds
 
 // hep by region not ethnic group
 
 // region: hep treated -tigray from 2004
gen rhep_treated = 0
replace rhep_treated = 1 if v101 == 1

// hep year from 2004 to 2016
gen rhep_year = 0
replace rhep_year = 1 if kbyear >= 2004

gen rhep_treated_post = rhep_treated*rhep_year

 reg infant     rhep_treated rhep_year rhep_treated_post momage sqage momedu residence twin KidFemale wealth  bord [iw=weight],  robust
 reg neonat    rhep_treated rhep_year rhep_treated_post momage sqage momedu residence twin KidFemale wealth  bord [iw=weight],  robust
 reg facdel    rhep_treated rhep_year rhep_treated_post momage sqage momedu residence twin KidFemale wealth  bord [iw=weight],  robust
 reg cmr       rhep_treated rhep_year rhep_treated_post momage sqage momedu residence twin KidFemale wealth  bord  [iw=weight], robust
 
***************************************************************************************
 	  
			  
*******************************************************************************************
*                    HDA regression (2006-2012-2016)
*******************************************************************************************

use "${KR16}/analysis_ready_kr.dta", clear 

drop if intyear == 2000 
drop if intyear == 2005

// Tigray during hda 2012-2016
 gen hda_treated = 0
 replace hda_treated = 1 if ethnic == 70

 // hda year 2012-2016
 gen hda_year = 0
 replace hda_year = 1 if kbyear >= 2012
 
 // the effect of hda favoritism
 gen hda_treated_post = hda_treated*hda_year
 
 cls
  reg  infant hda_treated hda_year hda_treated_post momage sqage momedu residence twin KidFemale wealth   bord [iw=weight],  robust
  reg  neonat hda_treated hda_year hda_treated_post momage sqage momedu residence twin KidFemale wealth     bord [iw=weight],  robust
  reg  cmr    hda_treated hda_year hda_treated_post momage sqage momedu residence twin KidFemale wealth     bord  [iw=weight], robust
  reg  facdel hda_treated hda_year hda_treated_post momage sqage momedu residence twin KidFemale wealth     bord [iw=weight],  robust
  reg  assistdoc hda_treated hda_year hda_treated_post momage sqage momedu residence twin KidFemale wealth  bord [iw=weight],  robust
 
  // hda by region not ethnic group
 
 // region: hep treated -tigray from 2004
gen rhda_treated = 0
replace rhda_treated = 1 if v101 == 1

// hep year from 2004 to 2016
gen rhda_year = 0
replace rhda_year = 1 if kbyear >= 2012

gen rhda_treated_post = rhda_treated*rhda_year

  reg  infant rhda_treated rhda_year rhda_treated_post momage sqage momedu residence twin KidFemale wealth   bord [iw=weight],  robust
  reg  neonat rhda_treated rhda_year rhda_treated_post momage sqage momedu residence twin KidFemale wealth     bord [iw=weight],  robust
  reg  cmr    rhda_treated rhda_year rhda_treated_post momage sqage momedu residence twin KidFemale wealth     bord  [iw=weight], robust
  reg  facdel rhda_treated rhda_year rhda_treated_post momage sqage momedu residence twin KidFemale wealth     bord [iw=weight],  robust
  reg  assistdoc rhda_treated rhda_year rhda_treated_post momage sqage momedu residence twin KidFemale wealth  bord [iw=weight],  robust
  
***************************************************************************** 


// FOUR RURAL REGIONS

use "${KR16}/analysis_ready_kr.dta", clear 
keep if ethnic == 1 | ethnic == 3 | v101 == 4 | v101 == 7






********************************************************************************

** IMMUNIZATION
*******************************************************************************
// vaccination or immunization 
use "${KR16}/analysis_ready_kr.dta", clear 
 // keep if intyear == 2016
// drop if h2 =
// recode h2 (1 2 3=1) (else=0), gen(ch_bcg_either) // percentage of fully vaccinated

// https://userforum.dhsprogram.com/index.php?t=msg&goto=20123&&srch=immunization#msg_20123


** Child_age = 12-23 months old
gen months = (v008-b3)
keep if childalive == 1 & months >= 12 & months <=23

gen child_age = months
replace child_age = 1 if childalive == 1 & months >= 12 & months <=13
replace child_age = 2 if childalive == 1 & months >= 14 & months <=15
replace child_age = 3 if childalive == 1 & months >= 16 & months <=17
replace child_age = 4 if childalive == 1 & months >= 18 & months <=19
replace child_age = 5 if childalive == 1 & months >= 20 & months <=21
replace child_age = 6 if childalive == 1 & months >= 22 & months <=23
label define child_age 1"12-13" 2"14-15" 3"16-17" 4"18-19" 5"20-21" 6"22-23"
label var child_age "Child age in months"
label val child_age child_age
svy:tab child_age, percent format (%4.1f) miss


** RECODE OF VACCINATION VARIABLES
gen BCG = inrange(h2,1,3)
gen Polio0 = inrange(h0,1,3)
gen Polio = inrange(h4,1,3)+inrange(h6,1,3)+inrange(h8,1,3)
gen DPT = inrange(h3,1,3)+inrange(h5,1,3)+inrange(h7,1,3)
gen measles = inrange(h9,1,3)


*** Loop ***
forvalues x = 1/3 {
	gen BCG`x' = (BCG>=`x')
	gen Polio`x' = (Polio>=`x')
	gen DPT`x' = (DPT>=`x')
	gen measles`x' = (measles>=`x')
}
**
recode h4 (1/3=1) (else=0), gen(Polios1)

** check if loop worked **
svy: tab wealth DPT3, percent format(%9.1f) miss row
svy: tab wealth DPT3, count format(%9.0f) miss

/* 
ALL BASIC VACCINATIONS:
----------------------
	BCG, measles and three doses each of DPT and 
	polio vaccine (excluding polio vaccine given at birth)
*/

cap drop vaccination
gen vaccination = (BCG==1 & DPT3==1 & Polio3==1 & measles1==1)
label var vaccination "Received all basic vaccinations"
label define vaccination 0"No" 1"Yes"
label values vaccination vaccination

*==============================================================================*
** DROP IF NOT WITHIN SAMPLE
keep if vaccination !=.

** CHECK
svy: tab vaccination, count format(%4.0f)
svy: tab vaccination, percent format(%4.1f)
svy: tab vaccination v101, percent format(%4.1f) // correct

// this code is great. I got 24.3 for 2011 and 38.4 for 2016

cls
 
svy: regress vaccination coethnic momage sqage momedu residence twin KidFemale wealth bord 
save "${KR16}/vaccinated.dta", replace


			  
*******************************************************************************************
*                Immunization  HDA regression (2006-2012-2016)
*******************************************************************************************


use "${KR16}/vaccinated.dta", clear
//drop if intyear == 2000 
drop if intyear == 2005

// Tigray during hda 2012-2016
 gen hda_treated = 0
 replace hda_treated = 1 if v101 == 1

 // hda year 2012-2016
 gen hda_year = 0
 replace hda_year = 1 if kbyear >= 2012
 
 // the effect of hda favoritism
 gen hda_treated_post = hda_treated*hda_year
 svy: tab vaccination v101
svy: reg vaccination hda_treated hda_year hda_treated_post junior powerless discriminated momage sqage momedu residence twin KidFemale wealth  bord i.ethnic i.intyear
corr vaccination hda_treated hda_year hda_treated_post discriminated junior powerless senior momage sqage momedu residence twin KidFemale wealth  bord

// HEP and HDA

use "${KR16}/vaccinated.dta", clear
gen hep_treated = 0
replace hep_treated = 1 if ethnic == 70
  //drop if intyear == 2016
 // drop if intyear == 2019
// hep year from 2004 to 2016
gen hep_year = 0
replace hep_year = 1 if kbyear >= 2006
gen hep_treated_post = senior*hep_year
 
 // the effect of hep and hda  maternal and child health (after 2006 or dhs 2011 and 2016 as treated or a kid born aft)
 // this is balance 11 year before and 11 after treatment, 2016-2006-1995
 // this is interesting because the gain of other regions(imr, nmr,cmr) is higher than Tigray during hep

 cls
 
 svy: reg  vaccination residence twin KidFemale wealth  bord  i.v101 i.kbyear
 svy: reg vaccination  senior hep_year hep_treated_post junior powerless discriminated momage sqage momedu residence twin KidFemale wealth  bord i.ethnic i.kbyear

 use "${KR16}/vaccinated.dta", clear
 collapse (mean)  vaccination [iw =weight], by( v101 kbyear)
 eststo vaccination: table v101 kbyear,  c(mean vaccination) missing format(%9.2f)
 esttab vaccination using "${output}/vaccination.tex", replace booktabs nonumber label ///
cells("mean(fmt(2))") collabels("Year/v101" "Mean Vaccination Rate") ///
title("Mean vaccination rates by year and region")


