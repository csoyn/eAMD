## 파일 설명

- for_FU_로 시작하는 R 파일 4개만 돌리면 됌.

### 1. for_FU_all_mean.R
* ATLAS allyear.txt로 만든 코호트 사용
1. source("./0_connection.R")
  - print("connection finish")
2. source("./1_ProcessingFunctions.R")
  - print("import functions finish")
3. source("./2_allYearCohort.R")
  3.1. 기간별 person_id list 파일 3개 생성 후 print 문
  | 다른 파일에서 계속 사용
    - id_all.csv
    - id_A.csv
    - id_B.csv
    - print("id_all, id_A, id_B File Creation Complete")
  3.2 First Drug 별로 나눈 person_id list 파일 4개 생성 후 print 문
  | 다른 파일에서 계속 사용
    - bevaPeople.csv
    - raniPeople.csv
    - afliPeople.csv
    - vertPeople.csv
    - print("bevaPeople, raniPeople, afliPeople, vertPeople File Creation Complete")
    3.3 check_table(data n수 저장한 table) 생성
    - all_checkTable.csv
    - print("all_checkTable.csv File Creation Complete")
4. source("./3_makeMeanTable_all.R")
  - 평균 테이블 생성
  - txt와 csv 둘 다 생성
  - print("FUAllMean.txt, FUAllMean.csv File Creation Complete")
  

### 2. for_FU_123_mean.R

1. source("./0_connection.R")
  - print("connection finish")
2. source("./1_ProcessingFunctions.R")
  - print("import functions finish")
3. source("./2_oneYearCohort.R") , source("./2_twoYearCohort.R"), source("./2_threeYearCohort.R")
  - 각 checkTable_one.csv , checkTable_two.csv, checkTable_three.csv 생성 
4. source("./3_makeMeanTable_one.R")
  - 각 평균 테이블 생성
  - txt와 csv 둘 다 생성
  - FUOneMean.txt, FUOneMean.csv
  - FUTwoMean.txt, FUTwoMean.csv
  - FUThreeMean.txt, FUThreeMean.csv
