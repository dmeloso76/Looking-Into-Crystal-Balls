* Replication code for "Looking into Crystal Balls: A Laboratory Experiment on Reputational Cheap Talk"
* Version: April 8, 2022

*ssc install estout

use "crystalballs_data.dta", clear

* EXPERIMENTAL DESIGN:
* 4 games:
*	HF: both reporters and evaluators are humans
*	CC: evaluators are computers and believe reporters always tell truth
*	CL: evaluators are computers, initially believe reporters randomize, update beliefs with generalized beta learning
*	CA: evaluators are computers and believe reporters randomize
* 2 q's (# blue cores in urn) for each game (6, 8)
* 8 experimental treatments (games manipulated between-subjects; q's manipulated within-subjects)
* 12 sessions
* 4 sessions for HF (1, 2, 5, 7), 4 sessions for CL (9, 10, 11, 12), 2 sessions for CA (4, 8), 2 sessions for CC (3, 6)
* 4 blocks of 16 periods in each session: 64 total periods in each session
* 2 blocks of 16 periods with each q in each session: 32 total periods with each q in each session
* 24 subjects per sessions (but 22 in session 1 and 23 in sessions 3, 4)
* 284 total subjects (94 for HF, 96 for CL, 47 for CA, 47 for CC)
* subjects 13-24 in games CL are computers
* 236 total human subjects (94 for HF, 48 for CL, 47 for CA, 47 for CC)
* in session 1 (HF), subject 11 (reporter, group 11) left after 25 periods, did not participate to periods 26-64

* CODEBOOK
* session: experimental session ID (1-12)
* game: experimental game played in experimental session (HF, CC, CL, CA)
* hf: dummy for game HF
* cc: dummy for game CC
* cl: dummy for game CL
* ca: dummy for game CA
* period_in_session: period in experimental session (1-64)
* block: block of periods in experimental session (1-4)
* lateblock: dummy for block > 2
* q: # of blue cores in urn in period (6, 8)
* q8: dummy for q == 8
* order: q's in 4 blocks experimental session (6868, 8686)
* period_in_block: period in same block of experimental session (1-16)
* period_in_treatment: period with same q of experimental session (1-32)
* subject_in_session: subject ID in experimental session (1-24)
* subject: unique subject ID in dataset
* group: group of subjects in period of experimental session (1-12)
* bluecore: dummy for blue core
* blueshell: dummy for blue shell
* bluereport: dummy for blue report
* orangereport_orangecore: dummy for orange report and orange core
* orangereport_bluecore: dummy for orange report and blue core
* bluereport_bluecore: dummy for blue report and blue core
* bluereport_orangecore: dummy for blue report and orange core
* oreport_ocore_vs_breport_bcore: dummy equal to 1 if orange report and orange core and equal to 0 if blue report and blue core
* breport_bcore_vs_breport_ocore: dummy equal to 1 if blue report and blue core and equal to 0 if blue report and orange core
* breport_ocore_vs_oreport_bcore: dummy equal to 1 if blue report and orange core and equal to 0 if orange report and blue core
* evaluator_choice: action chosen by evaluator
* bayes_evaluator_choice: assessment if evaluator formed beliefs as described in Appendix C
* behavioral_evaluator_choice: assessment if evaluator formed beliefs as described in Appendix D
* role: subject's role in experimental session (reporter, evaluator) 
* urn: type of urn (informative, uninformative) 
* reporter_choice: action chosen by reporter (truth, lie)
* reporter_truth: dummy for reporter who chooses truth
* payoff: subject's payoff in period

************
* FIGURE 2 *
************

* FIGURE 2 IS CREATED WITH THE PYTHON CODE IN THE FILE "crystalballs_figure2.py"
* THE CODE BELOW CREATES THE FILES "reporters_cluster.csv" WHICH IS USED AS INPUT IN THE PYTHON CODE

*********************************
* GENERATE DATASET FOR FIGURE 2 *
*********************************

use "crystalballs_data.dta", clear
keep if game=="HF"
keep if role=="reporter"
keep if lateblock==1
drop if subject==11
keep subject q reporter_truth
bys subject q: egen truthper = mean(reporter_truth)
drop reporter_truth
bys subject q: keep if _n==1
reshape wide truthper, i(subject)  j(q)
export delimited using "reporters_cluster.csv", replace

************
* FIGURE 3 *
************

* FIGURE 3 IS CREATED WITH THE PYTHON CODE IN THE FILE "crystalballs_figure3.py"
* THE CODE BELOW CREATES THE FILES "evaluators_boxplots.csv" WHICH IS USED AS INPUT IN THE PYTHON CODE

*********************************
* GENERATE DATASET FOR FIGURE 3 *
*********************************

use "crystalballs_data.dta", clear
keep if game=="HF"
keep if role=="evaluator"
keep if lateblock==1
gen report_core=""
replace report_core="OO" if bluereport==0 & bluecore==0
replace report_core="BB" if bluereport==1 & bluecore==1
replace report_core="BO" if bluereport==1 & bluecore==0
replace report_core="OB" if bluereport==0 & bluecore==1
drop if report_core==""
rename evaluator_choice assessment
gen q2 = "6/10"
replace q2 = "8/10" if q == 8
drop q
rename q2 q
keep subject period_in_session q assessment report_core
export delimited using "evaluators_boxplots.csv", replace

***********
* TABLE 1 *
***********

use "crystalballs_data.dta", clear
keep if game=="HF" & role=="evaluator"

su evaluator_choice if q8==0 & lateblock==1 & bluereport==1 & bluecore==1, detail
su evaluator_choice if q8==0 & lateblock==1 & bluereport==1 & bluecore==0, detail
su evaluator_choice if q8==0 & lateblock==1 & bluereport==0 & bluecore==1, detail
su evaluator_choice if q8==0 & lateblock==1 & bluereport==0 & bluecore==0, detail

***********
* TABLE 2 *
***********

use "crystalballs_data.dta", clear
keep if game=="HF" & role=="evaluator"

su evaluator_choice if q8==1 & lateblock==1 & bluereport==1 & bluecore==1, detail
su evaluator_choice if q8==1 & lateblock==1 & bluereport==1 & bluecore==0, detail
su evaluator_choice if q8==1 & lateblock==1 & bluereport==0 & bluecore==1, detail
su evaluator_choice if q8==1 & lateblock==1 & bluereport==0 & bluecore==0, detail

***********
* TABLE 3 *
***********

use "crystalballs_data.dta", clear
keep if game=="HF" & role=="evaluator"

xtset subject period_in_session
eststo clear
eststo: quietly xtreg evaluator_choice q8 if lateblock==1 & bluereport==1 & bluecore==1
eststo: quietly xtreg evaluator_choice q8 if lateblock==1 & bluereport==1 & bluecore==0
eststo: quietly xtreg evaluator_choice q8 if lateblock==1 & bluereport==0 & bluecore==1
eststo: quietly xtreg evaluator_choice q8 if lateblock==1 & bluereport==0 & bluecore==0
esttab est1 est2 est3 est4, star(* 0.05 ** 0.01) se b(2) keep(q8 _cons) obslast ///
coeflabel(q8 "q=8/10" _cons "Constant") ///
title("Evaluators' Assessments as a Function of q. Random Effects GLS Regression.") mtitle("B & B" "B & O" "O & B" "O & O")

***********
* TABLE 4 *
***********

use "crystalballs_data.dta", clear
keep if role=="reporter"

xtset subject period_in_session
eststo clear
eststo: quietly xtreg reporter_truth cc if (game=="CC" | game=="HF") & q8==0 & lateblock == 1
eststo: quietly xtreg reporter_truth cc if (game=="CC" | game=="HF") & q8==1 & lateblock == 1
eststo: quietly xtreg reporter_truth cl if (game=="CL" | game=="HF") & q8==0 & lateblock == 1
eststo: quietly xtreg reporter_truth cl if (game=="CL" | game=="HF") & q8==1 & lateblock == 1

esttab est1 est2 est3 est4, star(* 0.05 ** 0.01) se b(2) keep(ct cl _cons) obslast ///
title("Reporters' Behavior in Games with Computerized Evaluators. Random Effects GLS Regression.") mtitle("HF & CC, 6" "HF & CC, 8" "HF & CL, 6" "HF & CL, 8")

*******************
* FIGURES 4 AND 5 *
*******************

* FIGURES 4 AND 5 ARE CREATED WITH THE PYTHON CODE IN THE FILE "crystalballs_figures4&5.py"
* THE CODE BELOW CREATES THE FILE "evaluators_cluster.csv" WHICH IS USED AS INPUT IN THE PYTHON CODE

****************************************
* GENERATE DATASET FOR FIGURES 4 AND 5 *
****************************************

use "crystalballs_data.dta", clear
keep if game=="HF"
keep if role == "evaluator"
keep if lateblock==1

gen report_core=""
replace report_core="OO" if bluereport==0 & bluecore==0
replace report_core="BB" if bluereport==1 & bluecore==1
replace report_core="BO" if bluereport==1 & bluecore==0
replace report_core="OB" if bluereport==0 & bluecore==1
drop if report_core==""

rename evaluator_choice assessment
keep subject assessment report_core
bys subject report_core: egen avg_ass = mean(assessment)
bys subject report_core: keep if _n==1
drop assessment
reshape wide avg_ass, i(subject)  j(report_core) string

sort subject
save "evaluators_cluster_1.dta", replace

use "crystalballs_data.dta", clear
keep if game=="HF"
keep if role == "evaluator"
keep if lateblock==1

gen report_core=""
replace report_core="OO" if bluereport==0 & bluecore==0
replace report_core="BB" if bluereport==1 & bluecore==1
replace report_core="BO" if bluereport==1 & bluecore==0
replace report_core="OB" if bluereport==0 & bluecore==1
drop if report_core==""

rename evaluator_choice assessment
keep subject assessment report_core q
destring q, replace
egen report_core_q = concat(report_core q), punct(_)
drop report_core q
bys subject report_core_q: egen avg_ass = mean(assessment)
bys subject report_core_q: keep if _n==1
drop assessment
reshape wide avg_ass, i(subject)  j(report_core_q) string

sort subject
merge subject using "evaluators_cluster_1.dta"
drop _merge

export delimited using "evaluators_cluster.csv", replace
erase "evaluators_cluster_1.dta"

***********
* TABLE 5 *
***********

use "crystalballs_data.dta", clear
keep if game=="HF"
keep if role == "reporter"

eststo clear
xtset subject period_in_session
eststo: quietly xtreg reporter_truth lateblock if q8==0
eststo: quietly xtreg reporter_truth lateblock if q8==1
esttab est1 est2, star(* 0.05 ** 0.01) se b(2) keep(lateblock _cons) obslast ///
coeflabel(latebloc "2nd Block" _cons "Constant") ///
title("Reporters' Behavior as a Function of Experience. Random Effects GLS Regression") mtitle("q=6/10" "q=8/10")

***************************
* TABLE 6 COLUMNS (1)-(4) *
***************************

use "crystalballs_data.dta", clear
keep if game=="HF"
keep if role == "evaluator"

eststo clear
xtset subject period_in_session
eststo: quietly xtreg evaluator_choice lateblock if q8==0 & bluereport==1 & bluecore==1
eststo: quietly xtreg evaluator_choice lateblock if q8==0 & bluereport==1 & bluecore==0
eststo: quietly xtreg evaluator_choice lateblock if q8==0 & bluereport==0 & bluecore==1
eststo: quietly xtreg evaluator_choice lateblock if q8==0 & bluereport==0 & bluecore==0
esttab est1 est2 est3 est4, star(* 0.05 ** 0.01) se b(2) keep(lateblock _cons) obslast ///
coeflabel(latebloc "2nd Block" _cons "Constant") ///
title("Evaluators' Assessments as a Function of Experience. Random Effects GLS Regression, q=6/10") mtitle("B & B" "B & O" "O & B" "O & O")

***************************
* TABLE 6 COLUMNS (5)-(8) *
***************************

use "crystalballs_data.dta", clear
keep if game=="HF"
keep if role == "evaluator"

eststo clear
xtset subject period_in_session
eststo: quietly xtreg evaluator_choice lateblock if q8==1 & bluereport==1 & bluecore==1
eststo: quietly xtreg evaluator_choice lateblock if q8==1 & bluereport==1 & bluecore==0
eststo: quietly xtreg evaluator_choice lateblock if q8==1 & bluereport==0 & bluecore==1
eststo: quietly xtreg evaluator_choice lateblock if q8==1 & bluereport==0 & bluecore==0
esttab est1 est2 est3 est4, star(* 0.05 ** 0.01) se b(2) keep(lateblock _cons) obslast ///
coeflabel(latebloc "2nd Block" _cons "Constant") ///
title("Evaluators' Assessments as a Function of Experience. Random Effects GLS Regression, q=8/10") mtitle("B & B" "B & O" "O & B" "O & O")

***********
* TABLE 8 *
***********

use "crystalballs_data.dta", clear
keep if game=="HF"
keep if role == "evaluator"

eststo clear
xtset subject period_in_session
eststo: quietly xtreg bayes_evaluator_choice q8 if bluereport==1 & bluecore==1 & lateblock == 1
eststo: quietly xtreg bayes_evaluator_choice q8 if bluereport==1 & bluecore==0 & lateblock == 1
esttab est1 est2, star(* 0.05 ** 0.01) se b(2) obslast

***********
* TABLE 9 *
***********

use "crystalballs_data.dta", clear
keep if game=="HF"
keep if role == "evaluator"

eststo clear
xtset subject period_in_session
eststo: quietly xtreg behavioral_evaluator_choice q8 if bluereport==1 & bluecore==1 & lateblock == 1
eststo: quietly xtreg behavioral_evaluator_choice q8 if bluereport==1 & bluecore==0 & lateblock == 1
esttab est1 est2, star(* 0.05 ** 0.01) se b(2) obslast

************
* TABLE 10 *
************

use "crystalballs_data.dta", clear
keep if role=="reporter"

xtset subject period_in_session
eststo clear
eststo: quietly xtreg reporter_truth ca if (game=="CA" | game=="HF") & q8==0 & lateblock == 1
eststo: quietly xtreg reporter_truth ca if (game=="CA" | game=="HF") & q8==1 & lateblock == 1

esttab est1 est2, star(* 0.05 ** 0.01) se b(2) keep(ca _cons) obslast ///
title("Reporters' Behavior in Game with Agnostic Computerized Evaluators. Random Effects GLS Regression.") mtitle("HF & CA, 6" "HF & CA, 8")
