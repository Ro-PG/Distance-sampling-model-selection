
### Rocio Prieto Gonzalez
### simulation to check the bias in DS using model selection (with no movement)

### 30/07/15


### Corremos la simulacion con estos PARAMETROS:

  # md: model we generate the data from
  # DS: LT or PT scenario
  # no: Sample size
  # iter: num of iter= study areas 
      
md <- "hr"; DS <- "LT"    # det  0.3985266 0.4455014 0.4817196 0.5205241 0.5609136 0.5992798 0.6393930 0.6755607
md <- "hr"; DS <- "PT"    # det  0.2383091 0.2728835 0.2971727 0.3285672 0.3659181 0.4031258 0.4468134 0.4883202
md <- "EPS"; DS <- "LT"   # det  0.4080107 0.4607924 0.5162004 0.5637581 0.6140241 0.6634207 0.7109152 0.7584685
md <- "EPS"; DS <- "PT"   # det  0.2604815 0.3011746 0.3472085 0.3887942 0.4359555 0.4862024 0.5427761 0.6036573

no <- 60
w <- 30
monot <- "M"
max.par <- "all"
n.sim <- 4000

# We define the working directory (path)
path <- "D:\\Dropbox\\mcds"
setwd(path)
getwd()
# setwd("../")   # para volver a la carpeta anterior
source("fun_mcds_paper.R")


###### NO PARALLEL
set.seed(949587)
seeds <- sample(1:1e8, size = n.sim)
if(md=="EPS" & DS=="PT" & w==30){
  if(no==60){
    set.seed(949587); seeds <- sample(1:1e8, size = n.sim+1)
    seeds <- seeds[-1568]} 
  if(no==90){
    set.seed(949587); seeds <- sample(1:1e8, size = n.sim+2)
    seeds <- seeds[-723]
    seeds <- seeds[-3205]}}
if(md=="EPS" & DS=="PT" & w==20){
  if(no==240){
    set.seed(949587); seeds <- sample(1:1e8, size = n.sim+1)
    seeds <- seeds[-2523]}}

time <- system.time({
  RES <- lapply(1:n.sim, biasModSel, DS, no, w, md, monot, max.par, seeds)
})

###### GUARDAMOS los RESULTS
# we save the results in out.folder (dep. on the parameters)
# in the main mcds folder
setwd("../")
wd <- getwd()
# out.folder <- paste(wd,"/results/",n.sim,"iter/",md, "/",DS, "/",monot, "_", max.par, "par/N",no, sep="")
out.folder <- paste(wd,"/results", sep="")
guardar.datos(RES, no, DS, md, monot, max.par,out.folder)




