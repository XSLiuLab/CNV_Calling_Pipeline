setwd("C:/Users/Limbo/Rdata")
load("C:/Users/Limbo/filepaths.RData")

barcodes <- sub(pattern = ".*\\.?(TCGA-\\w+{2}-\\w{4}-\\w{3}-\\w{3}-\\w{4}-\\w{2}).*", 
               replacement = "\\1", filepaths)

#其中1228到1370的数据有问题先去掉
bad_barcodes <- barcodes[nchar(barcodes) != 28]

total <- setdiff(barcodes, bad_barcodes)

#提取patienID，去重
patientID = unique(substr(total, 1, 12))

#创建肿瘤和正常的池
tumor_pool <- vector("character", length(patientID))
normal_pool <- vector("character", length(patientID))
j <- 1
k <- 1
for (i in total) {
     if(as.integer(substr(i,14,15)) < 10){
       tumor_pool[j] <- c(i)
     
       j <- j+1
       
       }
     else{
       normal_pool[k] <- c(i)
     
       k <- k+1
       }
}

patient_ID <- vector("character", length(patientID))
tumor_ID <- vector("character", length(patientID))
tumor_path <- vector("character", length(patientID))
normal_ID <- vector("character", length(patientID))
normal_path <- vector("character", length(patientID))

#筛选tumor与normal


for (i in seq_along(patientID)) {
  barcode <- grep(patientID[i], total, value = TRUE)
  
  if (length(barcode) >= 2){
    
    if(length(barcode) == 2 & barcode[1] %in% tumor_pool & barcode[2] %in% normal_pool){
     
      tumor_ID[i] <- substr(barcode[1], 1, 15) 
      tumor_path[i] <- grep(barcode[1], filepaths, value = TRUE)
    
      normal_ID[i] <- substr(barcode[2], 1, 15)
      normal_path[i] <- grep(barcode[2], filepaths, value = TRUE)
      
    }
    else {
      tumor_ID[i] <- substr(barcode[1] ,1, 15)
      tumor_path[i] <- grep(barcode[1], filepaths, value = TRUE)
      barcode[1]<- NA
      q <- table(unlist(substr(total,14,15)))
      df <- data.frame(q)
      df <- data.frame(q,row.names = df$Var1)
      list_barcode <- vector("character", length(barcode))
      for (c in seq_along(barcode) ) {
        list_barcode[c] <- df[(substr(barcode[c],14,15)),]$Freq
      }
      sort(list_barcode,decreasing = FALSE)
      
      p_id <- rownames(which(df==list_barcode[2],arr.ind = TRUE))
      for (d in 2:(length(barcode)) ) 
        {
        if(p_id == substr(barcode[d],14,15)){
          
          patient_ID[i] <- patientID[i] 
          normal_ID[i] <- substr(barcode[d] ,1, 15)
          normal_path[i] <- grep(barcode[d], filepaths, value = TRUE) 
        }   
       }
      }
      
      
      
  
  }

  else {
  patient_ID[i] <- NA
  tumor_ID[i] <- NA
  tumor_path[i] <- NA
  normal_ID[i] <- NA
  normal_path[i] <- NA
  }
}

result <- data.frame(
  patient_ID <- patientID,
  tumor_ID <- tumor_ID,
  tumor_path <- tumor_path,
  normal_ID <- normal_ID,
  normal_path <- normal_path, 
  stringsAsFactors = FALSE
)

result <- na.omit(result)
#write.csv(result, file = "result.CSV", quote = FALSE)
