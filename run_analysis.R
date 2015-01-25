##Read the test files

#setwd("/Users/mestherlv/Dropbox/Tesis/curso_R/curso2/UCI HAR Dataset")

a=read.table(file="./test/subject_test.txt")
names(a)="subject"
x=read.table(file="./test/X_test.txt")
names(x)=paste("x",seq(1:ncol(x)),sep="")
y=read.table(file="./test/Y_test.txt")
names(y)="y"
data=data.frame(a,x,y)

data1=read.table("./test/Inertial Signals/body_acc_x_test.txt")
names(data1)=paste("body_acc_x",seq(1:ncol(data1)),sep="")
data2=read.table("./test/Inertial Signals/body_acc_y_test.txt")
names(data2)=paste("body_acc_y",seq(1:ncol(data2)),sep="")
data3=read.table("./test/Inertial Signals/body_acc_z_test.txt")
names(data3)=paste("body_acc_z",seq(1:ncol(data3)),sep="")

data4=read.table("./test/Inertial Signals/body_gyro_x_test.txt")
names(data4)=paste("body_gyro_x",seq(1:ncol(data4)),sep="")
data5=read.table("./test/Inertial Signals/body_gyro_y_test.txt")
names(data5)=paste("body_gyro_y",seq(1:ncol(data5)),sep="")
data6=read.table("./test/Inertial Signals/body_gyro_z_test.txt")
names(data6)=paste("body_gyro_z",seq(1:ncol(data6)),sep="")

data7=read.table("./test/Inertial Signals/total_acc_x_test.txt")
names(data7)=paste("total_acc_x",seq(1:ncol(data7)),sep="")
data8=read.table("./test/Inertial Signals/total_acc_y_test.txt")
names(data8)=paste("total_acc_y",seq(1:ncol(data8)),sep="")
data9=read.table("./test/Inertial Signals/total_acc_z_test.txt")
names(data9)=paste("total_acc_z",seq(1:ncol(data9)),sep="")

data=data.frame(data,data1,data2,data3,data4,data5,data6,data7,data8,data9)

##Read the train files

a=read.table(file="./train/subject_train.txt")
names(a)="subject"
x=read.table(file="./train/X_train.txt")
names(x)=paste("x",seq(1:ncol(x)),sep="")
y=read.table(file="./train/Y_train.txt")
names(y)="y"
datan=data.frame(a,x,y)

data1=read.table("./train/Inertial Signals/body_acc_x_train.txt")
names(data1)=paste("body_acc_x",seq(1:ncol(data1)),sep="")
data2=read.table("./train/Inertial Signals/body_acc_y_train.txt")
names(data2)=paste("body_acc_y",seq(1:ncol(data2)),sep="")
data3=read.table("./train/Inertial Signals/body_acc_z_train.txt")
names(data3)=paste("body_acc_z",seq(1:ncol(data3)),sep="")

data4=read.table("./train/Inertial Signals/body_gyro_x_train.txt")
names(data4)=paste("body_gyro_x",seq(1:ncol(data4)),sep="")
data5=read.table("./train/Inertial Signals/body_gyro_y_train.txt")
names(data5)=paste("body_gyro_y",seq(1:ncol(data5)),sep="")
data6=read.table("./train/Inertial Signals/body_gyro_z_train.txt")
names(data6)=paste("body_gyro_z",seq(1:ncol(data6)),sep="")

data7=read.table("./train/Inertial Signals/total_acc_x_train.txt")
names(data7)=paste("total_acc_x",seq(1:ncol(data7)),sep="")
data8=read.table("./train/Inertial Signals/total_acc_y_train.txt")
names(data8)=paste("total_acc_y",seq(1:ncol(data8)),sep="")
data9=read.table("./train/Inertial Signals/total_acc_z_train.txt")
names(data9)=paste("total_acc_z",seq(1:ncol(data9)),sep="")

datan=data.frame(datan,data1,data2,data3,data4,data5,data6,data7,data8,data9)

#Merges the training and the test sets to create one data set.
datatot=rbind(data,datan)
nrow(datatot)

#Extracts only the measurements on the mean and standard deviation for each measurement.
library(matrixStats)
meann=colMeans(datatot,na.rm=TRUE)
var=colVars(as.matrix(datatot),na.rm=TRUE)

datameanvar=data.frame(meann,var)
datameanvar=datameanvar[2:nrow(datameanvar),]
datameanvar

#Uses descriptive activity names to name the activities in the data set

act=read.table("activity_labels.txt")
features=read.table("features.txt")
datatot$y=as.factor(datatot$y)
levels(datatot$y)=unique(act[,2])

#Appropriately labels the data set with descriptive variable names. 

names(datatot)[2:562]=as.character(features[,2])


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(data.table)
dt=data.table(datatot)
dt2=dt[,lapply(.SD,mean),by="y,subject"]

dt22=data.frame(dt2)
names(dt22)[1]="activity"

write.table(dt22,file="data.final.txt")
names(datatot)


