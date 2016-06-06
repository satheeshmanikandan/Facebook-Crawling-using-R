#Install Rfacebook package from CRAN and run the following code.

#for extra fb crawling visit "http://pablobarbera.com/blog/archives/3.html","http://analyticsastra.com/complete-guide-facebook-data-mining-using-r/#a4"

require("Rfacebook")
fb_oauth<-fbOAuth(app_id="XXXXXXXXXXXXXXX", app_secret="YYYYYYYYYYYYYYYYYYYYYY",extended_permissions = TRUE)
#first method using FB Page name without space(Beware of Caps)
aamaadmiparty<-getPage("AamAadmiParty", fb_oauth, n = 35)    
#second method using FB Page id (get fb id from "http://findmyfbid.com/")
aamaadmiparty<-getPage(290805814352519, fb_oauth, n = 35)   

yesterday=Sys.Date()-1
today=Sys.Date()
#today=as.Date('02/23/2013',format='%m/%d/%Y')
#yesterday=today-1
e=getPage(290805814352519, fb_oauth, n=35,since=yesterday ,  until = today)
#dim(e)
#str(e)

#First method: error occurs and the loops stop executing if there is no post on that date
for(i in 1:519)
{
  yesterday=yesterday-1
  today=today-1
  e<-(rbind(e,getPage(290805814352519, fb_oauth,n=35, since=yesterday , until = today)))
}
write.csv(e,"D://New folder//Aam Aadmi7.csv")


#Second method: Loop continues to execute even the eroor occures or there is no post on that date
for(i in 1:365)
{
  yesterday=yesterday-1
  today=today-1
  le<-try(rbind(le,getPage(290805814352519, fb_oauth,n=35, since=yesterday , until = today)))
  if(class(le)=="try-error")next;
}
write.csv(le,"D://Aam Aadmi Party 2015.csv")

#Post wise crawling
x=getPost(aamaadmiparty$id[2],fb_oauth,n=30,comments=TRUE,likes=TRUE,n.likes=n,n.comments = n)
head(x)
x$post
x$likes
x$comments
# to update status
updateStatus("Aam Aadmi",fb_oauth)
