BB.marge <- function(csv.text,xts=FALSE){
	if(!is.character(csv.text)){
		stop("\ncsv.textの引数は文字列のみです")	
	}
	else if(length(grep("csv\\>",csv.text))==0){
		stop("\ncsvのファイル名を入力してください")
	}

	x = read.csv(csv.text)
	x = x[,-seq(3,ncol(x),by=3)]
	x = x[-1,]
	n.col = ncol(x)

	x.name = colnames(x)[-seq(2,n.col,by=2)]
	colnames(x)[seq(1,n.col,by=2)] = "Date"
	x = apply(x,2,function(x) replace(x,which(x==""),NA))
	
	if(n.col==2){
		cat("このデータはmargeする必要がありませんでした\n")
		return(x)
	}
	
	tmp  = merge(na.omit(x[,1:2]),na.omit(x[,3:4]),by="Date",all=TRUE)
	data = tmp[order(as.Date(tmp$Date)),]

	if(n.col==4){
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
	
	if(xts)	data = as.xts(data)
	
	data
}



