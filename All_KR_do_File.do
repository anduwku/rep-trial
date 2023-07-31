
f v101  == 8  // gambela

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


************************
hnic ==70 & kbyear >= 2004

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



  reg infant hep coethcent sqage momedu residence twin KidFemale wealth electricity bord i.ethnic, robust // after 2000

  reg infant coethre
