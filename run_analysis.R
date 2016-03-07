#1 Getting and Merging both datasets 
features<- read.table("./UCI HAR Dataset/features.txt")
act_lab<- read.table("./UCI HAR Dataset/activity_labels.txt")
        #getting and processing test dataset
        t_act_typ<- read.table("./UCI HAR Dataset/test/y_test.txt")
        t_act_per<- read.table("./UCI HAR Dataset/test/subject_test.txt")
        t_set<- read.table("./UCI HAR Dataset/test/X_test.txt")
        t_act_typ<-factor(t_act_typ$V1,labels = act_lab$V2)
        t_set_inc<-cbind(t_act_per,t_act_typ)
        colnames(t_set_inc)<- c("Subject","Activity")
        colnames(t_set)<-features$V2
        t_set_comp<-cbind(t_set_inc,t_set)

        #getting and processing train data set
        tr_act_typ<- read.table("./UCI HAR Dataset/train/y_train.txt")
        tr_act_per<- read.table("./UCI HAR Dataset/train/subject_train.txt")
        tr_set<- read.table("./UCI HAR Dataset/train/X_train.txt")
        tr_act_typ<-factor(tr_act_typ$V1,labels = act_lab$V2)#3
        tr_set_inc<-cbind(tr_act_per,tr_act_typ)#4
        colnames(tr_set_inc)<- c("Subject","Activity")#4
        colnames(tr_set)<-features$V2#4
        tr_set_comp<-cbind(tr_set_inc,tr_set)

comp_ds<-rbind(t_set_comp,tr_set_comp)#merged dataset
        
        #2 Extracts only the measurements on the mean and standard deviation for each measurement.
        comp_ds_meanstd<-comp_ds[,grepl("mean",names(comp_ds)) | grepl("std",names(comp_ds))]
        
        #3 Uses descriptive activity names to name the activities in the data set
        #(Already done while merging both the datasets #1 and marked at steps for #3 & #4)
        #4 Appropriately labels the data set with descriptive variable names.
        ds_meanstd<-cbind(comp_ds[,1:2],comp_ds_meanstd)
        
        #5From the data set in step 4, creates a second, independent tidy data 
        # set with the average of each variable for each activity and each subject.
        result<- ds_meanstd%>% group_by(Subject,Activity)%>% summarise_each(funs(mean))
        
        result_tidy<-arrange(result,desc(Subject))
        write.table(result_tidy,"r_analyis_result.txt", row.names = FALSE)#writing the result 
             
        
