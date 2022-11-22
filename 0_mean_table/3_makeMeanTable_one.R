
table_one <- matrix(ncol=16, byrow = T)
table_one <- data.frame(table_one)
table_name <- matrix(ncol=16, byrow =T)
table_name <- data.frame(table_name)
table_name[1,1] <- "Follow Up Year"
table_name[1,2] <- "one year"
table_one[1,1] = "First Drug"
table_one[1,2] = "Bevacizumab"
table_one[1,5] = "Ranibizumab"
table_one[1,8] = "Aflibercept"
table_one[1,11] = "Verteporfin"
table_one[1,14] = "All Drug"

table_one[2,1] = "2008 ~ 2012"
table_one[2,2] = "mean" 
table_one[2,3] = "sd"
table_one[2,4] = "num of P / C"
table_one[2,5] = "mean" 
table_one[2,6] = "sd"
table_one[2,7] = "num of P / C"
table_one[2,8] = "mean" 
table_one[2,9] = "sd" 
table_one[2,10] = "num of P / C" 
table_one[2,11] = "mean" 
table_one[2,12] = "sd" 
table_one[2,13] = "num of P / C"
table_one[2,14] = "mean" 
table_one[2,15] = "sd" 
table_one[2,16] = "num of P / C"
table_one[3,1] = "All Drug"
table_one[4,1] = "Bevacizumab"
table_one[5,1] = "Ranibizumab"
table_one[6,1] = "Aflibercept"
table_one[7,1] = "Verteporfin"


table_one[8,1] = "2013 ~ 2019"
table_one[8,2] = "mean" 
table_one[8,3] = "sd" 
table_one[8,4] = "num of P / C"
table_one[8,5] = "mean"
table_one[8,6] = "sd" 
table_one[8,7] = "num of P / C" 
table_one[8,8] = "mean" 
table_one[8,9] = "sd"
table_one[8,10] = "num of P / C"
table_one[8,11] = "mean" 
table_one[8,12] = "sd"
table_one[8,13] = "num of P / C"
table_one[8,14] = "mean" 
table_one[8,15] = "sd"
table_one[8,16] = "num of P / C"
table_one[9,1] = "All Drug"
table_one[10,1] = "Bevacizumab"
table_one[11,1] = "Ranibizumab"
table_one[12,1] = "Aflibercept"
table_one[13,1] = "Verteporfin"

table_one <- rbind(table_name, table_one)

##  Beva
# 2008 ~ 2019
firstBeva = allCountJoin %>% filter(PERSON_ID %in%bevaPeople$PERSON_ID)
# 연도 분리
firstBeva12 = firstBeva %>% filter(PERSON_ID %in% id_A$PERSON_ID)
firstBeva19 = firstBeva %>% filter(PERSON_ID %in% id_B$PERSON_ID)
# All 
cnt12 = firstBeva12$DRUG_TOTAL_COUNT
cnt19 = firstBeva19$DRUG_TOTAL_COUNT
table_one[4,2] = round(mean(cnt12), 2)
table_one[4,3] = round(sd(cnt12), 2)
table_one[4,4] = paste0(sum(cnt12),"/", nrow(firstBeva12))
table_one[10,2] = round(mean(cnt19), 2)
table_one[10,3] = round(sd(cnt19), 2)
table_one[10,4] = paste0(sum(cnt19),"/", nrow(firstBeva19))


#Beva
B_cnt12 = firstBeva12$BEVA_COUNT
B_cnt19 = firstBeva19$BEVA_COUNT
table_one[5,2] = round(mean(B_cnt12), 2)
table_one[5,3] = round(sd(B_cnt12), 2)
table_one[5,4] = paste0(sum(B_cnt12),"/", nrow(firstBeva12))
table_one[11,2] = round(mean(B_cnt19), 2)
table_one[11,3] = round(sd(B_cnt19), 2)
table_one[11,4] = paste0(sum(B_cnt19),"/", nrow(firstBeva19))


#(1) Rani
bevaRani12 = firstBeva12 %>% filter(RANI_COUNT > 0)
bevaRani19 = firstBeva19 %>% filter(RANI_COUNT > 0)
BR_cnt12 = bevaRani12$RANI_COUNT
BR_cnt19 = bevaRani19$RANI_COUNT
table_one[6,2] = round(mean(BR_cnt12), 2)
table_one[6,3] = round(sd(BR_cnt12), 2)
table_one[6,4] = paste0(sum(BR_cnt12),"/", nrow(bevaRani12))
table_one[12,2] = round(mean(BR_cnt19), 2)
table_one[12,3] = round(sd(BR_cnt19), 2)
table_one[12,4] = paste0(sum(BR_cnt19),"/", nrow(bevaRani19))


#(2) Afli
bevaAfli12 = firstBeva12 %>% filter(AFLI_COUNT > 0)
bevaAfli19 = firstBeva19 %>% filter(AFLI_COUNT > 0)
BA_cnt12 = bevaAfli12$AFLI_COUNT
BA_cnt19 = bevaAfli19$AFLI_COUNT
table_one[7,2] = round(mean(BA_cnt12), 2)
table_one[7,3] = round(sd(BA_cnt12), 2)
table_one[7,4] = paste0(sum(BA_cnt12),"/", nrow(bevaAfli12))
table_one[13,2] = round(mean(BA_cnt19), 2)
table_one[13,3] = round(sd(BA_cnt19), 2)
table_one[13,4] = paste0(sum(BA_cnt19),"/", nrow(bevaAfli19))

#(3) Vert
bevaVert12 = firstBeva12 %>% filter(VERT_COUNT > 0)
bevaVert19 = firstBeva19 %>% filter(VERT_COUNT > 0)
BV_cnt12 = bevaVert12$VERT_COUNT
BV_cnt19 = bevaVert19$VERT_COUNT

table_one[8,2] = round(mean(BV_cnt12), 2)
table_one[8,3] = round(sd(BV_cnt12), 2)
table_one[8,4] = paste0(sum(BV_cnt12),"/", nrow(bevaVert12))
table_one[14,2] = round(mean(BV_cnt19), 2)
table_one[14,3] = round(sd(BV_cnt19), 2)
table_one[14,4] = paste0(sum(BV_cnt19),"/", nrow(bevaVert19))


## Rani
# 2008 ~ 2019
firstRani = allCountJoin %>% filter(PERSON_ID %in% raniPeople$PERSON_ID)
# 연도 분리
firstRani12 = firstRani %>% filter(PERSON_ID %in% id_A$PERSON_ID)
firstRani19 = firstRani %>% filter(PERSON_ID %in% id_B$PERSON_ID)

# All 
RT_cnt12 = firstRani12$DRUG_TOTAL_COUNT
RT_cnt19 = firstRani19$DRUG_TOTAL_COUNT
table_one[4,5] = round(mean(RT_cnt12), 2)
table_one[4,6] = round(sd(RT_cnt12), 2)
table_one[4,7] = paste0(sum(RT_cnt12),"/", nrow(firstRani12))
table_one[10,5] = round(mean(RT_cnt19), 2)
table_one[10,6] = round(sd(RT_cnt19), 2)
table_one[10,7] = paste0(sum(RT_cnt19),"/", nrow(firstRani19))

#(0) Rani
R_cnt12 = firstRani12$RANI_COUNT
R_cnt19 = firstRani19$RANI_COUNT
table_one[6,5] = round(mean(R_cnt12), 2)
table_one[6,6] = round(sd(R_cnt12), 2)
table_one[6,7] = paste0(sum(R_cnt12),"/", nrow(firstRani12))
table_one[12,5] = round(mean(R_cnt19), 2)
table_one[12,6] = round(sd(R_cnt19), 2)
table_one[12,7] = paste0(sum(R_cnt19),"/", nrow(firstRani19))

#(1) Beva
raniBeva12 = firstRani12 %>% filter(BEVA_COUNT > 0)
raniBeva19 = firstRani19 %>% filter(BEVA_COUNT > 0)
RB_cnt12 = raniBeva12$BEVA_COUNT
RB_cnt19 = raniBeva19$BEVA_COUNT
table_one[5,5] = round(mean(RB_cnt12), 2)
table_one[5,6] = round(sd(RB_cnt12), 2)
table_one[5,7] = paste0(sum(RB_cnt12),"/", nrow(raniBeva12))
table_one[11,5] = round(mean(RB_cnt19), 2)
table_one[11,6] = round(sd(RB_cnt19), 2)
table_one[11,7] = paste0(sum(RB_cnt19),"/", nrow(raniBeva19))

#(2) Afli
raniAfli12 = firstRani12 %>% filter(AFLI_COUNT > 0)
raniAfli19 = firstRani19 %>% filter(AFLI_COUNT > 0)
RA_cnt12 = raniAfli12$AFLI_COUNT
RA_cnt19 = raniAfli19$AFLI_COUNT
table_one[7,5] = round(mean(RA_cnt12), 2)
table_one[7,6] = round(sd(RA_cnt12), 2)
table_one[7,7] = paste0(sum(RA_cnt12),"/", nrow(raniAfli12))
table_one[13,5] = round(mean(RA_cnt19), 2)
table_one[13,6] = round(sd(RA_cnt19), 2)
table_one[13,7] = paste0(sum(RA_cnt19),"/", nrow(raniAfli19))

#(3) Vert
raniVert12 = firstRani12 %>% filter(VERT_COUNT > 0)
raniVert19 = firstRani19 %>% filter(VERT_COUNT > 0)
RV_cnt12 = raniVert12$VERT_COUNT
RV_cnt19 = raniVert19$VERT_COUNT
table_one[8,5] = round(mean(RV_cnt12), 2)
table_one[8,6] = round(sd(RV_cnt12), 2)
table_one[8,7] = paste0(sum(RV_cnt12),"/", nrow(raniVert12))
table_one[14,5] = round(mean(RV_cnt19), 2)
table_one[14,6] = round(sd(RV_cnt19), 2)
table_one[14,7] = paste0(sum(RV_cnt19),"/", nrow(raniVert19))


## 4-3 Afli
# 2008 ~ 2019
firstAfli = allCountJoin %>% filter(PERSON_ID %in% afliPeople$PERSON_ID)
# 연도 분리
firstAfli12 = firstAfli %>% filter(PERSON_ID %in% id_A$PERSON_ID)
firstAfli19 = firstAfli %>% filter(PERSON_ID %in% id_B$PERSON_ID)
# All 
AT_cnt12 = firstAfli12$DRUG_TOTAL_COUNT
AT_cnt19 = firstAfli19$DRUG_TOTAL_COUNT
table_one[4,8] = round(mean(AT_cnt12), 2)
table_one[4,9] = round(sd(AT_cnt12), 2)
table_one[4,10] = paste0(sum(AT_cnt12),"/", nrow(firstAfli12))
table_one[10,8] = round(mean(AT_cnt19), 2)
table_one[10,9] = round(sd(AT_cnt19), 2)
table_one[10,10] = paste0(sum(AT_cnt19),"/", nrow(firstAfli19))

#(0) Afli
AA_cnt12 = firstAfli12$AFLI_COUNT
AA_cnt19 = firstAfli19$AFLI_COUNT
table_one[7,8] = round(mean(AA_cnt12), 2)
table_one[7,9] = round(sd(AA_cnt12), 2)
table_one[7,10] = paste0(sum(AA_cnt12),"/", nrow(firstAfli12))
table_one[13,8] = round(mean(AA_cnt19), 2)
table_one[13,9] = round(sd(AA_cnt19), 2)
table_one[13,10] = paste0(sum(AA_cnt19),"/", nrow(firstAfli19))

#(1) Beva
afliBeva12 = firstAfli12 %>% filter(BEVA_COUNT > 0)
afliBeva19 = firstAfli19 %>% filter(BEVA_COUNT > 0)
AB_cnt12 = afliBeva12$BEVA_COUNT
AB_cnt19 = afliBeva19$BEVA_COUNT

table_one[5,8] = round(mean(AB_cnt12), 2)
table_one[5,9] = round(sd(AB_cnt12), 2)
table_one[5,10] = paste0(sum(AB_cnt12),"/", nrow(afliBeva12))
table_one[11,8] = round(mean(AB_cnt19), 2)
table_one[11,9] = round(sd(AB_cnt19), 2)
table_one[11,10] = paste0(sum(AB_cnt19),"/", nrow(afliBeva19))

#(2) Rani
afliRani12 = firstAfli12 %>% filter(RANI_COUNT > 0)
afliRani19 = firstAfli19 %>% filter(RANI_COUNT > 0)
AR_cnt12 = afliRani12$RANI_COUNT
AR_cnt19 = afliRani19$RANI_COUNT
table_one[6,8] = round(mean(AR_cnt12), 2)
table_one[6,9] = round(sd(AR_cnt12), 2)
table_one[6,10] = paste0(sum(AR_cnt12),"/", nrow(afliRani12))
table_one[12,8] = round(mean(AR_cnt19), 2)
table_one[12,9] = round(sd(AR_cnt19), 2)
table_one[12,10] = paste0(sum(AR_cnt19),"/", nrow(afliRani19))

#(3) Vert
afliVert12 = firstAfli12 %>% filter(VERT_COUNT > 0)
afliVert19 = firstAfli19 %>% filter(VERT_COUNT > 0)
AV_cnt12 = afliVert12$VERT_COUNT
AV_cnt19 = afliVert19$VERT_COUNT
table_one[8,8] = round(mean(AV_cnt12), 2)
table_one[8,9] = round(sd(AV_cnt12), 2)
table_one[8,10] = paste0(sum(AV_cnt12),"/", nrow(afliVert12))
table_one[14,8] = round(mean(AV_cnt19), 2)
table_one[14,9] = round(sd(AV_cnt19), 2)
table_one[14,10] = paste0(sum(AV_cnt19),"/", nrow(afliVert19))

## 4-4 Vert
#2008 ~ 2019
#연도 분리
firstVert = allCountJoin %>% filter(PERSON_ID %in% vertPeople$PERSON_ID)
# 연도 분리
firstVert12 = firstVert %>% filter(PERSON_ID %in% id_A$PERSON_ID)
firstVert19= firstVert %>% filter(PERSON_ID %in% id_B$PERSON_ID)
# All 
VT_cnt12 = firstVert12$DRUG_TOTAL_COUNT
VT_cnt19 = firstVert19$DRUG_TOTAL_COUNT
table_one[4,11] = round(mean(VT_cnt12), 2)
table_one[4,12] = round(sd(VT_cnt12), 2)
table_one[4,13] = paste0(sum(VT_cnt12),"/", nrow(firstVert12))
table_one[10,11] = round(mean(VT_cnt19), 2)
table_one[10,12] = round(sd(VT_cnt19), 2)
table_one[10,13] = paste0(sum(VT_cnt19),"/", nrow(firstVert19))

#(0) Vert
VV_cnt12 = firstVert12$VERT_COUNT
VV_cnt19 = firstVert19$VERT_COUNT
table_one[8,11] = round(mean(VV_cnt12), 2)
table_one[8,12] = round(sd(VV_cnt12), 2)
table_one[8,13] = paste0(sum(VV_cnt12),"/", nrow(firstVert12))
table_one[14,11] = round(mean(VV_cnt19), 2)
table_one[14,12] = round(sd(VV_cnt19), 2)
table_one[14,13] = paste0(sum(VV_cnt19),"/", nrow(firstVert19))

#(1) Beva
vertBeva12 = firstVert12 %>% filter(BEVA_COUNT > 0)
vertBeva19 = firstVert19 %>% filter(BEVA_COUNT > 0)
VB_cnt12 = vertBeva12$BEVA_COUNT
VB_cnt19 = vertBeva19$BEVA_COUNT
table_one[5,11] = round(mean(VB_cnt12), 2)
table_one[5,12] = round(sd(VB_cnt12), 2)
table_one[5,13] = paste0(sum(VB_cnt12),"/", nrow(vertBeva12))
table_one[11,11] = round(mean(VB_cnt19), 2)
table_one[11,12] = round(sd(VB_cnt19), 2)
table_one[11,13] = paste0(sum(VB_cnt19),"/", nrow(vertBeva19))


#(2) Rani
vertRani12 = firstVert12 %>% filter(RANI_COUNT > 0)
vertRani19 = firstVert19 %>% filter(RANI_COUNT > 0)
VR_cnt12 = vertRani12$RANI_COUNT
VR_cnt19 = vertRani19$RANI_COUNT
table_one[6,11] = round(mean(VR_cnt12), 2)
table_one[6,12] = round(sd(VR_cnt12), 2)
table_one[6,13] = paste0(sum(VR_cnt12),"/", nrow(vertRani12))
table_one[12,11] = round(mean(VR_cnt19), 2)
table_one[12,12] = round(sd(VR_cnt19), 2)
table_one[12,13] = paste0(sum(VR_cnt19),"/", nrow(vertRani19))

#(2) Afli
vertAfli12 = firstVert12 %>% filter(AFLI_COUNT > 0)
vertAfli19 = firstVert19 %>% filter(AFLI_COUNT > 0)
VA_cnt12 = vertAfli12$AFLI_COUNT
VA_cnt19 = vertAfli19$AFLI_COUNT
table_one[7,11] = round(mean(VA_cnt12), 2)
table_one[7,12] = round(sd(VA_cnt12), 2)
table_one[7,13] = paste0(sum(VA_cnt12),"/", nrow(vertAfli12))
table_one[13,11] = round(mean(VA_cnt19), 2)
table_one[13,12] = round(sd(VA_cnt19), 2)
table_one[13,13] = paste0(sum(VA_cnt19),"/", nrow(vertAfli19))


## 7. First Drug 구분하지 않음
allCountA = allCountJoin%>%
  filter(PERSON_ID %in% id_A$PERSON_ID)
allCountB = allCountJoin %>%
  filter(PERSON_ID %in% id_B$PERSON_ID)

# period A
allInjection = allCountA$DRUG_TOTAL_COUNT
allBeva =  allCountA$BEVA_COUNT[!is.na(allCountA$BEVA_COUNT)]
allRani =  allCountA$RANI_COUNT[!is.na(allCountA$RANI_COUNT)]
allAfli =  allCountA$AFLI_COUNT[!is.na(allCountA$AFLI_COUNT)]
allVert =  allCountA$VERT_COUNT[!is.na(allCountA$VERT_COUNT)]

table_one[4,14] = round(mean(allInjection), 2)
table_one[4,15] = round(sd(allInjection), 2)
table_one[4,16] = paste0(sum(allInjection),"/", length(allInjection))

table_one[5,14] = round(mean(allBeva), 2)
table_one[5,15] = round(sd(allBeva), 2)
table_one[5,16] = paste0(sum(allBeva),"/", length(allBeva))

table_one[6,14] = round(mean(allRani), 2)
table_one[6,15] = round(sd(allRani), 2)
table_one[6,16] = paste0(sum(allRani),"/", length(allRani))

table_one[7,14] = round(mean(allAfli), 2)
table_one[7,15] = round(sd(allAfli), 2)
table_one[7,16] = paste0(sum(allAfli),"/", length(allAfli))

table_one[8,14] = round(mean(allVert), 2)
table_one[8,15] = round(sd(allVert), 2)
table_one[8,16] = paste0(sum(allVert),"/", length(allVert))

# period B
allInjection_B = allCountB$DRUG_TOTAL_COUNT
allBeva_B =  allCountB$BEVA_COUNT[!is.na(allCountB$BEVA_COUNT)]
allRani_B =  allCountB$RANI_COUNT[!is.na(allCountB$RANI_COUNT)]
allAfli_B =  allCountB$AFLI_COUNT[!is.na(allCountB$AFLI_COUNT)]
allVert_B =  allCountB$VERT_COUNT[!is.na(allCountB$VERT_COUNT)]


table_one[10,14] = round(mean(allInjection_B), 2)
table_one[10,15] = round(sd(allInjection_B), 2)
table_one[10,16] = paste0(sum(allInjection_B),"/", length(allInjection_B))

table_one[11,14] = round(mean(allBeva_B), 2)
table_one[11,15] = round(sd(allBeva_B), 2)
table_one[11,16] = paste0(sum(allBeva_B),"/", length(allBeva))

table_one[12,14] = round(mean(allRani_B), 2)
table_one[12,15] = round(sd(allRani_B), 2)
table_one[12,16] = paste0(sum(allRani_B),"/", length(allRani_B))

table_one[13,14] = round(mean(allAfli_B), 2)
table_one[13,15] = round(sd(allAfli_B), 2)
table_one[13,16] = paste0(sum(allAfli_B),"/", length(allAfli_B))

table_one[14,14] = round(mean(allVert_B), 2)
table_one[14,15] = round(sd(allVert_B), 2)
table_one[14,16] = paste0(sum(allVert_B),"/", length(allVert_B))

write.csv(table_one, file = "./FUOneMean.txt", fileEncoding = 'EUC-KR')
write.csv(table_one, file = "./FUOneMean.csv", fileEncoding = 'EUC-KR')

print("FUOneMean.txt, FUOneMean.csv File Creation Complete")