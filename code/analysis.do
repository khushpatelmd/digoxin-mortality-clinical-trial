*Author: Khush Patel, drpatelkhush@gmail.com

*Logging the session
log using "H:\Biostat Final Submission\Khush.smcl"

*Importing data
import delimited "H:\DIG_FINAL.csv"

*Checking normality of each variable by Shapiro Wilk test (limited utility due to large sample size), histogram and qqplot.

*to check for normality of age distribution by treatment
histogram age if treatment==0
qnorm age if treatment==0
swilk age if treatment==0
histogram age if treatment==1
qnorm age if treatment==1
swilk age if treatment==1

*to check for normality of BMI distribution by treatment
histogram bmi if treatment==0
qnorm bmi if treatment==0
swilk bmi if treatment==0
histogram bmi if treatment==1
qnorm bmi if treatment==1
swilk bmi if treatment==1

*to check for normality of Ejection Fraction distribution by treatment
histogram ejf_per if treatment==0
qnorm ejf_per if treatment==0
swilk ejf_per if treatment==0
histogram ejf_per  if treatment==1
qnorm ejf_per if treatment==1
swilk ejf_per if treatment==1

*to check for normality of creatinine distribution by treatment
histogram creat if treatment==0
qnorm creat if treatment==0
swilk creat if treatment==0
histogram creat if treatment==1
qnorm creat if treatment==1
swilk creat if treatment==1

*to check for normality of potassium distribution by treatment. Does not seem normally distributed but we assume normality by invoking CLT due to large sample size
histogram klevel if treatment==0
qnorm klevel if treatment==0
swilk klevel if treatment==0
histogram klevel if treatment==1
qnorm klevel if treatment==1
swilk klevel if treatment==1

*to check for normality of CHF duration distribution by treatment. Does not seem normally distributed but we assume normality by invoking CLT due to large sample size
histogram chfdur if treatment==0
qnorm chfdur if treatment==0
swilk chfdur if treatment==0
histogram chfdur if treatment==1
qnorm chfdur if treatment==1
swilk chfdur if treatment==1

*to check for normality of heartrate distribution by treatment
histogram heartrte if treatment==0
qnorm heartrte if treatment==0
swilk heartrte if treatment==0
histogram heartrte if treatment==1
qnorm heartrte if treatment==1
swilk heartrte if treatment==1

*to check for normality of systolic BP distribution by treatment
histogram sysbp if treatment==0
qnorm sysbp if treatment==0
swilk sysbp if treatment==0
histogram sysbp if treatment==1
qnorm sysbp if treatment==1
swilk sysbp if treatment==1

*to check for normality of diastolic BP distribution by treatment
histogram diabp if treatment==0
qnorm diabp if treatment==0
swilk diabp if treatment==0
histogram diabp if treatment==1
qnorm diabp if treatment==1
swilk diabp if treatment==1

*t test for continuous variables and Chi2 test for categorical variables
* T test for age by treatment
ttest age, by(treatment)
* T test for BMI by treatment
ttest bmi, by(treatment)
* T test for ejection fraction by treatment
ttest ejf_per, by(treatment)
* T test for creatinine by treatment
ttest creat, by(treatment)
* T test for potassium by treatment
ttest klevel, by(treatment)
* T test for CHF duration by treatment
ttest chfdur, by(treatment)
* T test for heart rate by treatment
ttest heartrte, by(treatment)
* T test for Systolic BP by treatment
ttest sysbp, by(treatment)
* T test for Diastolic BP by treatment
ttest diabp, by(treatment)

*chi2 for sex:
by treatment, sort : tab sex
*checking to see if chi square can be used here:
tabi 2308 2318 \ 667 666, expected
*performing chi square test
tabi 2308 2318 \ 667 666, chi2

*chi2 for race:
by treatment, sort : tab race
*checking to see if chi square can be used here:
tabi 2543 2560 \ 432 424, expected
*performing chi square test
tabi 2543 2560 \ 432 424, chi2

*chi2 test for rales
by treatment, sort : tab rales
*checking to see if chi square can be used here:
tabi 838 851 \ 2137 2133, expected
*performing chi square test
tabi 838 851 \ 2137 2133, chi2

*chi2 test for peripheral edema
by treatment, sort : tab pedema
*checking to see if chi square can be used here:
tabi 1445 1405 \ 1530 1579, expected
*performing chi square test
tabi 1445 1405 \ 1530 1579, chi2

*chi2 test for dyspnea on exertion
by treatment, sort : tab exertdys
*checking to see if chi square can be used here:
tabi 133 139 \ 2842 2845, expected
*performing chi square test
tabi 133 139 \ 2842 2845, chi2

*Bar graph to compare NYHA functional class between treatment groups 
graph bar (count), over(functcls) over(treatment) ytitle(Number of subjects) title(Figure1)
*Hypothesis test, CHI2 test for NYHA by treatment
by treatment, sort : tab functcls
tabulate functcls treatment, expected
tabulate functcls treatment, chi2

*Bar graph to compare the proportions of patients hospitalized for cardiovascular events between the treatment groups
graph bar (count), over (cvd) over (treatment)
*Hypothesis test, two sample proportions test for hospitalized for cardiovascular events between the treatment groups
prtest cvd, by(treatment)
*Bar graph to compare the proportions of patients who died between the treatment groups
graph bar (count), over (death) over (treatment) title (proportions of patients who died between the treatment groups) ytitle(Number of subjects)
*Hypothesis test, two sample proportions test for the proportions of patients who died between the treatment groups
prtest death, by(treatment)

*Visually looking at relationship between BMI and treatment:
graph box bmi, over(treatment) title(comparison of bmi by treatment group)

*checking for independence of observations
duplicates report patientid

*checking for linearity

* The following command plots a scatter the bmi and treatment. The titile and subtitble options adds titile and subtitle to the plot
scatter bmi treatment, title("scatter plot") subtitle("BMI and Treatment")

* Normality of the two variables is checked with Shapiro-Wilk test
swilk bmi treatment
histogram bmi
qnorm bmi

* The two variables are normally distributed. So use Pearson's correlation. 
* The following command checks Pearson's correlation between bmi and treatment. The sig option adds p-value of the correlation 
pwcorr bmi treatment, sig

* Next, assume bmi and treatment are not normally distributed and use Spearman's correlation.
* Spearman's correlation directly gives p-value
spearman bmi treatment

* The following part is simple linear regression based on the same data 

* The following command is for linear regression. The first variable is always the dependent variable, followed by independent variables 
* In our case, bmi is the dependent variable, treatment is the independent variable 

regress bmi treatment

* The following part is use residual to check model assumptions 
* The following commands creates residuals, standardized residuals and studentized residuals, respectively. 
* Note: The first word after predict is the name of residual, you can change it and it will be added to the dataset. 
* The word after comma is the type of residual, you cannot change it arbitarily 

* Note: These residuals can only be created after a linear regression is done */

predict residuals, residuals
predict rstandard, rstandard
predict rstudent, rstudent

*  residual vs. fitted value plot to check constant variance assumption. 
* rvfplot function is used to do this. Option yline(0) adds a line of y = 0 
rvfplot, yline(0)

* The following commands check constant variance assumption. They are residuals vs. predictor plots
* If no obvious pattern, assumption holds. If level of scatter changes with predictor, assumption does not hold
scatter residuals treatment		
scatter rstandard treatment
scatter rstudent treatment

*Since BMI is not normal, need to transform it. need to remove outliers from the bmi
*generating box plot to define outliers
graph box bmi, over(treatment)

*drop all values >40 and <15 as outliers as they lie above the whiskers in box plots.
keep if bmi <40 | bmi <15

*checking for which transformation to use for BMI:
ladder bmi

*Applying log transformation (as chi2 value is smallest)
gen transformed_bmi = log(bmi)

*checking normality of transformed_bmi
swilk transformed_bmi
histogram transformed_bmi
qnorm transformed_bmi

*The following command plots a scatter the transformed_bmi and treatment. The titile and subtitble options adds titile and subtitle to the plot
scatter transformed_bmi treatment, title("scatter plot") subtitle("transformed_bmi and Treatment")

*performing linear regression of transformed_bmi and treatment
regress transformed_bmi treatment

predict residuals, residuals
predict rstandard, rstandard
predict rstudent, rstudent

* Need to create residual vs. fitted value plot to check constant variance assumption. 
* rvfplot function is used to do this. Option yline(0) adds a line of y = 0 
rvfplot, yline(0)

* The following commands check constant variance assumption. They are residuals vs. predictor plots
* If no obvious pattern, assumption holds. If level of scatter changes with predictor, assumption does not hold
scatter residuals treatment		
scatter rstandard treatment
scatter rstudent treatment

*closing the log file
log close


