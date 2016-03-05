# DataCleaningProject
#Aim:To describe how the code works
  #Introduction:
  The data was from experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating 
  the training data and 30% the test data.

#Obtaining the data :-
'''features<- read.table("./UCI HAR Dataset/features.txt")
   act_lab<- read.table("./UCI HAR Dataset/activity_labels.txt")
        t_act_typ<- read.table("./UCI HAR Dataset/test/y_test.txt")
        t_act_per<- read.table("./UCI HAR Dataset/test/subject_test.txt")
        t_set<- read.table("./UCI HAR Dataset/test/X_test.txt")'''
        #Addding on subject number, converting the activity number to activity
        #labels for all the colomns in the data set 
        
     '''t_act_typ<-factor(t_act_typ$V1,labels = act_lab$V2)''' #converted activity to a factors
     '''t_set_inc<-cbind(t_act_per,t_act_typ)
        colnames(t_set_inc)<- c("Subject","Activity)'''#adding subject and Activity
     '''colnames(t_set)<-features$V2'''# setting appropritate colomn names 
     '''t_set_comp<-cbind(t_set_inc,t_set)''' # cleaned test data set 
        
        #Repeat process for train data set 
        
     '''comp_ds<-rbind(t_set_comp,tr_set_comp)'''#merged dataset train and test
        
        #2 Extracts only the measurements on the mean and standard deviation for each measurement.
     '''comp_ds_meanstd<-comp_ds[,grepl("mean",names(comp_ds)) | grepl("std",names(comp_ds))]'''
        
         #4 Appropriately labels the data set with descriptive variable names.
     '''ds _meanstd<-cbind(comp_ds[,1:2],comp_ds_meanstd)'''
        
        # set with the average of each variable for each activity and each subject.
     '''result<- ds_meanstd%>% group_by(Subject,Activity)%>% summarise_each(funs(mean))
         result_tidy<-arrange(result,desc(Subject))
         write.table(result_tidy,"r_analyis_result.txt", row.names = FALSE)'''#writing the result 
