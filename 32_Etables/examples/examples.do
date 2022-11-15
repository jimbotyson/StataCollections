
clear all
collect clear

// THIS DO-FILE REQUIRES Stata 17 OR HIGHER
version 17

capture cd "$GoogleDriveWork"
capture cd "$GoogleDriveLaptop"
capture cd "$Presentations"
capture cd ".\Talks\AllTalks\32_Etables\examples\"

set linesize 120
capture log close
log using examples_etable, replace

global Width16x9 = 1920*2
global Height16x9 = 1080*2

global Width4x3 = 1440*2
global Height4x3 = 1080*2

// set the graph scheme 
set scheme s1color
// Define the local macro "GraphNum" so that graphs are numbered sequentially
local GraphNum = 1

// Delete all .png files from the "graphs" folder
shell erase .\graphs\*.png /Q
// Define the local macro "GraphNum" so that graphs are numbered sequentially
local GraphNum = 1

/*
graph export ./graphs/`GraphNum'_LinearFemaleBar.png, as(png)           ///
             width($Width16x9) height($Height16x9) replace
local ++GraphNum
*/


webuse nhanes2l

describe age sex race bmi diabetes highbp


// =============================================================================
//                             Tables for one model
// =============================================================================

// Basic example
// =============
logistic diabetes age i.sex i.race bmi
etable

// -replay-
etable, replay

// -keep-
etable, replay keep(age sex race bmi)

// -cstat()-
// ====================
etable, replay cstat(_r_b) cstat(_r_p)    

// -cstat(, format())-
etable, replay cstat(_r_b, nformat(%4.2f))  ///
               cstat(_r_p, nformat(%6.4f))  

		
// -cstat(_r_ci, cidelimiter())-
etable, replay cstat(_r_b, nformat(%4.2f))                  ///
               cstat(_r_ci, cidelimiter(,) nformat(%6.2f)) 		

		
// -showstars-
etable, replay showstars showstarsnote
        
// -stars()-
etable, replay                                           ///
        showstars showstarsnote                          ///
        stars(.05 "*" .01 "**" .001 "***", attach(_r_b))
        
        
// -mstat(, format())-
etable, replay mstat(N) mstat(aic) mstat(bic)        
        
     
// -mstat(, format())-
quietly logistic diabetes age i.sex i.race bmi
etable, keep(age sex race bmi)                            ///
        cstat(_r_b, nformat(%4.2f))                       ///
        cstat(_r_ci, cidelimiter(,) nformat(%6.2f))       ///
        showstars showstarsnote                           /// 
        stars(.05 "*" .01 "**" .001 "***", attach(_r_b))  ///
        mstat(N) mstat(aic) mstat(bic)                    ///
        mstat(pseudo_r2 = e(r2_p))
        
 
 
 
// -mstat(, format())-
etable, replay  ///
        mstat(N,   nformat(%8.0fc) label("Observations"))             ///
        mstat(aic, nformat(%5.0f))                                    ///
        mstat(bic, nformat(%5.0f))                                    ///
        mstat(pseudo_r2 = e(r2_p), nformat(%5.4f) label("Pseudo R2")) 
 
 
       
// title
etable, replay ///
        title("Table 5: Logistic Regression Model For Diabetes")
        
 
// titlestyles
etable, replay ///
        title("Table 5: Logistic Regression Model For Diabetes")      ///
        titlestyles(font(Lucida Console, size(14) bold)) 
 
// note
etable, replay  ///
        note("Data Source: NHANES, 1981")
 
// notestyle
etable, replay                                             ///
        notestyles(font(Lucida Console, size(10) italic))
 
// column
etable, replay column(dvlabel)
 
 
// export
etable, replay                          /// 
        export(Diabetes.docx, replace)  
 
 
  
  
// Full command
// ======================================================================

quietly logistic diabetes age i.sex i.race bmi

etable, keep(age sex race bmi) column(dvlabel)                        ///
        cstat(_r_b, nformat(%4.2f))                                   ///
        cstat(_r_ci, cidelimiter(,) nformat(%6.2f))                   ///
        showstars showstarsnote                                       /// 
        stars(.05 "*" .01 "**" .001 "***", attach(_r_b))              ///
        mstat(N,   nformat(%8.0fc) label("Observations"))             ///
        mstat(aic, nformat(%5.0f))                                    ///
        mstat(bic, nformat(%5.0f))                                    ///
        mstat(pseudo_r2 = e(r2_p), nformat(%5.4f) label("Pseudo R2")) ///
        title("Table 5: Logistic Regression Model For Diabetes")      ///
        titlestyles(font(Lucida Console, size(14) bold))              ///
        note("Data Source: NHANES, 1981")                             ///
        notestyles(font(Lucida Console, size(10) italic))             ///  
        export(Diabetes.docx, replace) 
  
  
  
quietly logistic diabetes age i.sex i.race bmi 
ereturn list 
  
  
  
  
// Multilevel Models
// =============================================================================
mixed bmi age i.sex || strata:, nolog
estat sd, var post
etable
   
 

  
  
  
// =============================================================================  
//                        TABLES FOR MULTIPLE MODELS
// =============================================================================  
  

// append 
// ================================================
quietly logistic diabetes age i.sex i.race bmi
etable

quietly logistic diabetes age
etable, append

quietly logistic diabetes i.sex
etable, append
  
quietly logistic diabetes i.race
etable, append

quietly logistic diabetes bmi
etable, append

etable, replay column(index)

etable, replay column(index)   ///
        title("Table 5: Logistic Regression Models for Diabetes")


        
        
quietly logistic diabetes age i.sex i.race bmi
etable, mstat(N,   nformat(%8.0fc) label("Observations"))             ///
        mstat(aic, nformat(%5.0f))                                    ///
        mstat(bic, nformat(%5.0f))                                    ///
        mstat(pseudo_r2 = e(r2_p), nformat(%5.4f) label("Pseudo R2"))

quietly logistic diabetes age
etable, append                                                        ///
        mstat(N,   nformat(%8.0fc) label("Observations"))             ///
        mstat(aic, nformat(%5.0f))                                    ///
        mstat(bic, nformat(%5.0f))                                    ///
        mstat(pseudo_r2 = e(r2_p), nformat(%5.4f) label("Pseudo R2"))

quietly logistic diabetes i.sex
etable, append                                                        ///
        mstat(N,   nformat(%8.0fc) label("Observations"))             ///
        mstat(aic, nformat(%5.0f))                                    ///
        mstat(bic, nformat(%5.0f))                                    ///
        mstat(pseudo_r2 = e(r2_p), nformat(%5.4f) label("Pseudo R2"))
  
quietly logistic diabetes i.race
etable, append                                                        ///
        mstat(N,   nformat(%8.0fc) label("Observations"))             ///
        mstat(aic, nformat(%5.0f))                                    ///
        mstat(bic, nformat(%5.0f))                                    ///
        mstat(pseudo_r2 = e(r2_p), nformat(%5.4f) label("Pseudo R2"))

quietly logistic diabetes bmi
etable, append column(index)                                          ///
        title("Table 5: Logistic Regression Models for Diabetes")     ///
        mstat(N,   nformat(%8.0fc) label("Observations"))             ///
        mstat(aic, nformat(%5.0f))                                    ///
        mstat(bic, nformat(%5.0f))                                    ///
        mstat(pseudo_r2 = e(r2_p), nformat(%5.4f) label("Pseudo R2"))

        
// seperate models with estimates()
// ==================================================== 
quietly logistic diabetes age i.sex 
estimates store Diabetes

quietly logistic highbp age i.sex
estimates store Hypertension  

// estimates()  
etable, estimates(Diabetes Hypertension) 

// showeq  
etable, replay showeq  

// eqrecode()  
etable, replay eqrecode(diabetes = highbp) showeq

// column()  
etable, replay column(estimates)    





// Multivariate models with equations
// ========================================================
gsem (diabetes <- age i.sex, logit)       ///
     (highbp <- age i.sex, logit), nolog
* let -etable- do its thing
etable, showeq
* show the layout
collect layout
* change the layout
collect layout (colname#result[_r_b _r_se]) (coleq#stars[value])


 








        
        
        
		
        
        
        
        
        
// =============================================================================		
//                             MARGINAL PREDICTIONS
// =============================================================================
quietly logistic diabetes age i.sex i.race bmi
quietly margins sex race
etable, margins	

logistic diabetes age i.sex i.race bmi
margins sex race, at(age=40 bmi=20)
etable, margins	
	
quietly logistic diabetes age i.sex i.race bmi
quietly margins, at(age=(20(10)60))
etable, margins	

collect layout

collect label dim _at "Age (years)", modify
collect label levels _at 1 "Age = 20"    ///
                         2 "Age = 30"    ///
                         3 "Age = 40"    ///
                         4 "Age = 50"    ///
                         5 "Age = 60"

collect layout (coleq#colname[]#result[_r_b _r_se] result[N]) ///
               (etable_depvar#stars[value])
		
		
		
		
// COMBINE PARAMETER ESTIMATES AND MARGINAL PREDICTIONS
// =============================================================================		
quietly logistic diabetes i.sex i.race
etable

quietly margins sex race
etable, append margins
		
quietly logistic diabetes i.sex i.race
quietly etable
quietly margins sex race
etable, append margins keep(sex race)                 ///
        cstat(_r_b, nformat(%4.2f))                   ///
        cstat(_r_ci, cidelimiter(,) nformat(%5.2f))				

collect layout        
        
collect label levels etable_depvar 1 "Odds Ratio"    ///
                                   2 "Pr(diabetes)", modify        
        
collect layout (coleq#colname[sex race]#result[_r_b _r_ci])  ///
               (etable_depvar#stars[value])
	
	

	
    
    
    
// =============================================================================    
//                            Basics of -collect-    
// =============================================================================    
    
quietly logistic diabetes age i.highbp
quietly etable
collect layout

collect dims

collect levelsof highbp

collect label list highbp

collect label levels highbp 0 "No" 1 "Yes"

collect label list colname

collect label levels colname highbp "Hypertension", modify

collect label list colname





quietly logistic diabetes age i.highbp
quietly etable
collect label levels highbp 0 "No" 1 "Yes"
collect label levels colname highbp "Hypertension", modify
collect preview







collect clear
collect: logistic diabetes age i.sex
collect layout (coleq#colname[]#result[_r_b _r_se] result[N])  ///
               (etable_depvar#stars[value])
               


               
               
               

    
    
    
    
    
    
    
    
log close




	
	
		
		
		
		
