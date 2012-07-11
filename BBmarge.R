<<<<<<< HEAD
BB.marge <- function(csv.text,xts=FALSE){
	if(!is.character(csv.text)){
		stop("\ncsv.textã®å¼•æ•°ã¯æ–‡å­—åˆ—ã®ã¿ã§ã™")	
	}
	else if(length(grep("csv\\>",csv.text))==0){
		stop("\ncsvã®ãƒ•ã‚¡ã‚¤ãƒ«åã‚’å…¥åŠ›ã—ã¦ãã ã•ã„")
	}

	x = read.csv(csv.text)
	x = x[,-seq(3,ncol(x),by=3)]
	x = x[-1,]
	n.col = ncol(x)

=======
BB.marge <- function(cvs.text,xts=FALSE){
	if(xts){
		library(xts)
	}
	
	if(length(grep("csv__>",cvs.text))==0){
		stop("_ncsv‚Ìƒtƒ@ƒCƒ‹–¼‚ğ“ü—Í‚µ‚Ä‚­‚¾‚³‚¢")
	}

	x = read.csv(cvs.text)
	
	if(ncol(x)==2){
		cat("ƒf[ƒ^‚ªˆê‚Â‚Å‚ ‚é‚½‚ß®Œ`‚Ì‚İ‚ğs‚¢‚Ü‚µ‚½_n")
		x = x[-1,]
		x.name = colnames(x)[1]
		Date.name = as.Date(x[,1])
		x = data.frame(as.numeric(as.character(x[,-1])))
		colnames(x) = x.name
		rownames(x) = Date.name
		if(xts){
			x = as.xts(x)
		}
		return(x)
	}
	
	x = x[,-seq(3,ncol(x),by=3)]
	x = x[-1,]
	n.col=ncol(x)
	
	
	
>>>>>>> bugfix
	x.name = colnames(x)[-seq(2,n.col,by=2)]
	colnames(x)[seq(1,n.col,by=2)] = "Date"
	x = apply(x,2,function(x) replace(x,which(x==""),NA))

	if(n.col==2){
<<<<<<< HEAD
		cat("ã“ã®ãƒ‡ãƒ¼ã‚¿ã¯margeã™ã‚‹å¿…è¦ãŒã‚ã‚Šã¾ã›ã‚“ã§ã—ãŸ\n")
=======
		cat("‚±‚Ìƒf[ƒ^‚Ímarge‚·‚é•K—v‚ª‚ ‚è‚Ü‚¹‚ñ‚Å‚µ‚½_n")
>>>>>>> bugfix
		return(x)
	}
	
	tmp  = merge(na.omit(x[,1:2]),na.omit(x[,3:4]),by="Date",all=TRUE)
	data = tmp[order(as.Date(tmp$Date)),]

	if(n.col==4){
		browser()
		Date.name = data$Date
		data = data[,-1]
		data = apply(data,2,function(x) as.numeric(as.character(x)))
		colnames(data) = x.name
		rownames(data) = Date.name
		return(data)
	}

	rm(tmp)

	for(j in seq(5,n.col,by=2)){
		a    = merge(data,na.omit(x[,j:(j+1)]),by="Date",all=TRUE)
     		data = a[order(as.Date(a$Date)),] 
	}


	Date.name      = data$Date
	data           = data[,-1]
	data           = apply(data,2,function(x) as.numeric(as.character(x)))
	colnames(data) = x.name
	rownames(data) = Date.name
	
<<<<<<< HEAD
	if(xts)	data = as.xts(data)
	
	data
}



=======
	if(xts){
		data = as.xts(data)
	}
	data
}
>>>>>>> bugfix
