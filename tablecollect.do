clear all

use https://www.ucl.ac.uk/~ccaajim/results

list if outofrange != 0

replace teacher = 3 if outofrange == 1

drop outofrange

replace maths = 57 if maths >= 100

format maths %9.2g



collect clear
sort gender teacher
collect: by gender teacher: summarize maths
collect style cell result[mean], nformat(%5.2f)
collect layout (gender) (teacher) (result[mean])


collect style cell result[mean], nformat(%5.2f)
collect layout (teacher) (gender) (result[mean])


collect label dim gender "Sex", modify
collect style cell result[mean], nformat(%5.2f)
collect title "Some summary statistics"
collect notes "These are not very useful"
collect layout (teacher) (gender) (result[mean])

collect label dim gender "Sex", modify
collect label levels gender 1 "Women" 2 "Men", modify
collect style title, font(Arial, size(18) color(blue) variant(smallcaps) bold italic underline)
collect style cell result[mean], nformat(%5.2f)
collect title "Some summary statistics"
collect notes "These are not very useful"
collect layout (teacher) (gender) (result[mean])


collect label dim gender "Sex", modify
collect label levels gender 1 "Women" 2 "Men", modify
collect label levels teacher 1 "Class One" 2 "Class Two" 3 "Class Three", modify
collect style title, font(Arial, size(18) color(blue) variant(smallcaps) bold italic underline)
collect style cell, border( all, width(1) pattern(single) color(darkmagenta) )
collect style cell result[mean], nformat(%5.2f)
collect title "Some summary statistics"
collect notes "These are not very useful"
collect layout (teacher) (gender) (result[mean])
collect export tabletest.html, replace

