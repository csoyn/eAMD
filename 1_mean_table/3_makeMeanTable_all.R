

all_table1 <- matrix(ncol=13, byrow = T)
all_table1 <- data.frame(all_table1)
all_table1[1,1] = "First Drug"
all_table1[1,2] = "Bevacizumab"
all_table1[1,5] = "Ranibizumab"
all_table1[1,8] = "Aflibercept"
all_table1[1,11] = "Verteporfin"

all_table1[2,1] = "2008 ~ 2012"
all_table1[2,2] = "mean" 
all_table1[2,3] = "sd"
all_table1[2,4] = "num of P / C"
all_table1[2,5] = "mean" 
all_table1[2,6] = "sd"
all_table1[2,7] = "num of P / C"
all_table1[2,8] = "mean" 
all_table1[2,9] = "sd" 
all_table1[2,10] = "num of P / C" 
all_table1[2,11] = "mean" 
all_table1[2,12] = "sd" 
all_table1[2,13] = "num of P / C" 
all_table1[3,1] = "Bevacizumab"
all_table1[4,1] = "Ranibizumab"
all_table1[5,1] = "Aflibercept"
all_table1[6,1] = "Verteporfin"


all_table1[7,1] = "2013 ~ 2019"
all_table1[7,2] = "mean" 
all_table1[7,3] = "sd" 
all_table1[7,4] = "num of P / C"
all_table1[7,5] = "mean"
all_table1[7,6] = "sd" 
all_table1[7,7] = "num of P / C" 
all_table1[7,8] = "mean" 
all_table1[7,9] = "sd"
all_table1[7,10] = "num of P / C"
all_table1[7,11] = "mean" 
all_table1[7,12] = "sd"
all_table1[7,13] = "num of P / C"
all_table1[8,1] = "Bevacizumab"
all_table1[9,1] = "Ranibizumab"
all_table1[10,1] = "Aflibercept"
all_table1[11,1] = "Verteporfin"

## First Drug == Bevacizumab
# 2008 ~ 2019
firstBeva = allCountJoin %>% filter(PERSON_ID %in% bevaPeople$PERSON_ID)
# 연도 분리
firstBeva12 = firstBeva %>% filter(PERSON_ID %in% id_A$PERSON_ID)
firstBeva19 = firstBeva %>% filter(PERSON_ID %in% id_B$PERSON_ID)
#(0) Beva
all_table1[3,2] = round(mean(firstBeva12$BEVA_COUNT), 2)
all_table1[3,3] = round(sd(firstBeva12$BEVA_COUNT), 2)
all_table1[3,4] = paste0(sum(firstBeva12$BEVA_COUNT),"/", nrow(firstBeva12))
all_table1[8,2] = round(mean(firstBeva19$BEVA_COUNT), 2)
all_table1[8,3] = round(sd(firstBeva19$BEVA_COUNT), 2)
all_table1[8,4] = paste0(sum(firstBeva19$BEVA_COUNT), "/", nrow(firstBeva19))
#(1) Rani
bevaRani12 = firstBeva12 %>% filter(RANI_COUNT > 0)
bevaRani19 = firstBeva19 %>% filter(RANI_COUNT > 0)
all_table1[4,2] = round(mean(bevaRani12$RANI_COUNT), 2)
all_table1[4,3] = round(sd(bevaRani12$RANI_COUNT), 2)
all_table1[4,4] = paste0(sum(bevaRani12$RANI_COUNT), "/", nrow(bevaRani12))
all_table1[9,2] = round(mean(bevaRani19$RANI_COUNT), 2)
all_table1[9,3] = round(sd(bevaRani19$RANI_COUNT), 2)
all_table1[9,4] = paste0(sum(bevaRani19$RANI_COUNT), "/", nrow(bevaRani19))

#(2) Afli
bevaAfli12 = firstBeva12 %>% filter(AFLI_COUNT > 0)
bevaAfli19 = firstBeva19 %>% filter(AFLI_COUNT > 0)

all_table1[5,2] = round(mean(bevaAfli12$AFLI_COUNT), 2)
all_table1[5,3] = round(sd(bevaAfli12$AFLI_COUNT), 2)
all_table1[5,4] = paste0(sum(bevaAfli12$AFLI_COUNT), "/", nrow(bevaAfli12))

all_table1[10,2] = round(mean(bevaAfli19$AFLI_COUNT), 2)
all_table1[10,3] = round(sd(bevaAfli19$AFLI_COUNT), 2)
all_table1[10,4] = paste0(sum(bevaAfli19$AFLI_COUNT), "/", nrow(bevaAfli19))

#(3) Vert
bevaVert12 = firstBeva12 %>% filter(VERT_COUNT > 0)
bevaVert19 = firstBeva19 %>% filter(VERT_COUNT > 0)
all_table1[6,2] = round(mean(bevaVert12$VERT_COUNT), 2)
all_table1[6,3] = round(sd(bevaVert12$VERT_COUNT), 2)
all_table1[6,4] = paste0(sum(bevaVert12$VERT_COUNT), "/",nrow(bevaVert12))

all_table1[11,2] = round(mean(bevaVert19$VERT_COUNT), 2)
all_table1[11,3] = round(sd(bevaVert19$VERT_COUNT), 2)
all_table1[11,4] = paste0(sum(bevaVert19$VERT_COUNT), "/",nrow(bevaVert19))


## First Drug == Ranibizumab
# 2008 ~ 2019
firstRani = allCountJoin %>% filter(PERSON_ID %in% raniPeople$PERSON_ID)
# 연도 분리
firstRani12 = firstRani %>% filter(PERSON_ID %in% id_A$PERSON_ID)
firstRani19 = firstRani %>% filter(PERSON_ID %in% id_B$PERSON_ID)

#(0) Rani
R_cnt12 = firstRani12$RANI_COUNT
R_cnt19 = firstRani19$RANI_COUNT
all_table1[4,5] = round(mean(R_cnt12), 2)
all_table1[4,6] = round(sd(R_cnt12), 2)
all_table1[4,7] = paste0(sum(R_cnt12),"/", nrow(firstRani12))
all_table1[9,5] = round(mean(R_cnt19), 2)
all_table1[9,6] = round(sd(R_cnt19), 2)
all_table1[9,7] = paste0(sum(R_cnt19),"/", nrow(firstRani19))

#(1) Beva
raniBeva12 = firstRani12 %>% filter(BEVA_COUNT > 0)
raniBeva19 = firstRani19 %>% filter(BEVA_COUNT > 0)
B_cnt12 = raniBeva12$BEVA_COUNT
B_cnt19 = raniBeva19$BEVA_COUNT
all_table1[3,5] = round(mean(B_cnt12), 2)
all_table1[3,6] = round(sd(B_cnt12), 2)
all_table1[3,7] = paste0(sum(B_cnt12),"/", nrow(raniBeva12))
all_table1[8,5] = round(mean(B_cnt19), 2)
all_table1[8,6] = round(sd(B_cnt19), 2)
all_table1[8,7] = paste0(sum(B_cnt19),"/", nrow(raniBeva19))

#(2) Afli
raniAfli12 = firstRani12 %>% filter(AFLI_COUNT > 0)
raniAfli19 = firstRani19 %>% filter(AFLI_COUNT > 0)
A_cnt12 = raniAfli12$AFLI_COUNT
A_cnt19 = raniAfli19$AFLI_COUNT
all_table1[5,5] = round(mean(A_cnt12), 2)
all_table1[5,6] = round(sd(A_cnt12), 2)
all_table1[5,7] = paste0(sum(A_cnt12),"/", nrow(raniAfli12))
all_table1[10,5] = round(mean(A_cnt19), 2)
all_table1[10,6] = round(sd(A_cnt19), 2)
all_table1[10,7] = paste0(sum(A_cnt19),"/", nrow(raniAfli19))

#(3) Vert
raniVert12 = firstRani12 %>% filter(VERT_COUNT > 0)
raniVert19 = firstRani19 %>% filter(VERT_COUNT > 0)
V_cnt12 = raniVert12$VERT_COUNT
V_cnt19 = raniVert19$VERT_COUNT
all_table1[6,5] = round(mean(V_cnt12), 2)
all_table1[6,6] = round(sd(V_cnt12), 2)
all_table1[6,7] = paste0(sum(V_cnt12),"/", nrow(raniVert12))
all_table1[11,5] = round(mean(V_cnt19), 2)
all_table1[11,6] = round(sd(V_cnt19), 2)
all_table1[11,7] = paste0(sum(V_cnt19),"/", nrow(raniVert19))

## First Drug == Aflibercept
# 2008 ~ 2019
firstAfli = allCountJoin %>% filter(PERSON_ID %in% afliPeople$PERSON_ID)
# 연도 분리
firstAfli12 = firstAfli %>% filter(PERSON_ID %in% id_A$PERSON_ID)
firstAfli19 = firstAfli %>% filter(PERSON_ID %in% id_B$PERSON_ID)

#(0) Afli
AA_cnt12 = firstAfli12$AFLI_COUNT
AA_cnt19 = firstAfli19$AFLI_COUNT
all_table1[5,8] = round(mean(AA_cnt12), 2)
all_table1[5,9] = round(sd(AA_cnt12), 2)
all_table1[5,10] = paste0(sum(AA_cnt12),"/", nrow(firstAfli12))
all_table1[10,8] = round(mean(AA_cnt19), 2)
all_table1[10,9] = round(sd(AA_cnt19), 2)
all_table1[10,10] = paste0(sum(AA_cnt19),"/", nrow(firstAfli19))

#(1) Beva
afliBeva12 = firstAfli12 %>% filter(BEVA_COUNT > 0)
afliBeva19 = firstAfli19 %>% filter(BEVA_COUNT > 0)
AB_cnt12 = afliBeva12$BEVA_COUNT
AB_cnt19 = afliBeva19$BEVA_COUNT
all_table1[3,8] = round(mean(AB_cnt12), 2)
all_table1[3,9] =  round(sd(AB_cnt12), 2)
all_table1[3,10] = paste0(sum(AB_cnt12),"/", nrow(afliBeva12))
all_table1[8,8] = round(mean(AB_cnt19), 2)
all_table1[8,9] = round(sd(AB_cnt19), 2)
all_table1[8,10] = paste0(sum(AB_cnt19),"/", nrow(afliBeva19))

#(2) Rani
afliRani12 = firstAfli12 %>% filter(RANI_COUNT > 0)
afliRani19 = firstAfli19 %>% filter(RANI_COUNT > 0)
AR_cnt12 = afliRani12$RANI_COUNT
AR_cnt19 = afliRani19$RANI_COUNT
all_table1[4,8] = round(mean(AR_cnt12), 2)
all_table1[4,9] =  round(sd(AR_cnt12), 2)
all_table1[4,10] = paste0(sum(AR_cnt12),"/", nrow(afliRani12))
all_table1[9,8] = round(mean(AR_cnt19), 2)
all_table1[9,9] =  round(sd(AR_cnt19), 2)
all_table1[9,10] = paste0(sum(AR_cnt19),"/", nrow(afliRani19))

#(3) Vert
afliVert12 = firstAfli12 %>% filter(VERT_COUNT > 0)
afliVert19 = firstAfli19 %>% filter(VERT_COUNT > 0)
AV_cnt12 = afliVert12$VERT_COUNT
AV_cnt19 = afliVert19$VERT_COUNT
all_table1[6,8] = round(mean(AV_cnt12), 2)
all_table1[6,9] =  round(sd(AV_cnt12), 2)
all_table1[6,10] = paste0(sum(AV_cnt12),"/", nrow(afliVert12))
all_table1[11,8] = round(mean(AV_cnt19), 2)
all_table1[11,9] =  round(sd(AV_cnt19), 2)
all_table1[11,10] = paste0(sum(AV_cnt19),"/", nrow(afliVert19))

## First Drug == Verteporfin
#2008 ~ 2019
#연도 분리
firstVert = allCountJoin %>% filter(PERSON_ID %in% vertPeople$PERSON_ID)
# 연도 분리
firstVert12 = firstVert %>% filter(PERSON_ID %in% id_A$PERSON_ID)
firstVert19= firstVert %>% filter(PERSON_ID %in% id_B$PERSON_ID)

#(0) Vert
VV_cnt12 = firstVert12$VERT_COUNT
VV_cnt19 = firstVert19$VERT_COUNT
all_table1[6,11] = round(mean(VV_cnt12), 2)
all_table1[6,12] = round(sd(VV_cnt12), 2)
all_table1[6,13] = paste0(sum(VV_cnt12),"/", nrow(firstVert12))
all_table1[11,11] = round(mean(VV_cnt19), 2)
all_table1[11,12] = round(sd(VV_cnt19), 2)
all_table1[11,13] = paste0(sum(VV_cnt19),"/", nrow(firstVert19))


#(1) Beva
vertBeva12 = firstVert12 %>% filter(BEVA_COUNT > 0)
vertBeva19 = firstVert19 %>% filter(BEVA_COUNT > 0)
VB_cnt12 = vertBeva12$BEVA_COUNT
VB_cnt19 = vertBeva19$BEVA_COUNT
all_table1[3,11] = round(mean(VB_cnt12), 2)
all_table1[3,12] = round(sd(VB_cnt12), 2)
all_table1[3,13] = paste0(sum(VB_cnt12),"/", nrow(vertBeva12))
all_table1[8,11] = round(mean(VB_cnt19), 2)
all_table1[8,12] = round(sd(VB_cnt19), 2)
all_table1[8,13] = paste0(sum(VB_cnt19),"/", nrow(vertBeva19))
#(2) Rani
vertRani12 = firstVert12 %>% filter(RANI_COUNT > 0)
vertRani19 = firstVert19 %>% filter(RANI_COUNT > 0)
VR_cnt12 = vertRani12$RANI_COUNT
VR_cnt19 = vertRani19$RANI_COUNT
all_table1[4,11] = round(mean(VR_cnt12), 2)
all_table1[4,12] = round(sd(VR_cnt12), 2)
all_table1[4,13] = paste0(sum(VR_cnt12),"/", nrow(vertRani12))
all_table1[9,11] = round(mean(VR_cnt19), 2)
all_table1[9,12] = round(sd(VR_cnt19), 2)
all_table1[9,13] = paste0(sum(VR_cnt19),"/", nrow(vertRani19))

#(2) Afli
vertAfli12 = firstVert12 %>% filter(AFLI_COUNT > 0)
vertAfli19 = firstVert19 %>% filter(AFLI_COUNT > 0)
VA_cnt12 = vertAfli12$AFLI_COUNT
VA_cnt19 = vertAfli19$AFLI_COUNT
all_table1[5,11] = round(mean(VA_cnt12), 2)
all_table1[5,12] = round(sd(VA_cnt12), 2)
all_table1[5,13] = paste0(sum(VA_cnt12),"/", nrow(vertAfli12))
all_table1[10,11] = round(mean(VA_cnt19), 2)
all_table1[10,12] = round(sd(VA_cnt19), 2)
all_table1[10,13] = paste0(sum(VA_cnt19),"/", nrow(vertAfli19))

write.csv(all_table1, file = "./FUAllMean.txt", fileEncoding = 'EUC-KR')
write.csv(all_table1, file = "./FUAllMean.csv", fileEncoding = 'EUC-KR')



print("FUAllMean.txt, FUAllMean.csv File Creation Complete")



