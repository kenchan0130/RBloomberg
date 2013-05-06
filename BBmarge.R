BB.marge <- function(csv.text,xts=FALSE){
	
	if(xts){
		library(xts)
	}
	
	if(!is.character(csv.text)){
		stop("\ncsv.textの引数は文字列のみです")	
	}
	else if(length(grep("csv\\>",csv.text))==0){
		stop("\ncsvのファイル名を入力してください")
	}
	
	trim <- function(obj) {
		obj[-which(obj[,1]==""),]
	}

	x    = read.csv(csv.text, stringsAsFactors=FALSE)
	x.na = which(is.na(x[1,]))
	x    = x[,-x.na]
	n.col = ncol(x)
	col.name = x[1,]
	date.vec = grep("\\<Date\\>", col.name)
	x.name = colnames(x)[date.vec]
	
	x = data.frame(x[-1,])
	colnames(x) = col.name
	

	param.n = diff(date.vec)-1
	if (sum(param.n==param.n[1])!=length(param.n==param.n[1])) stop("\nデータの個数がそれぞれ異なっている可能性があります")
	kekka = lapply(seq(param.n[1]), function(n){
				data = trim(x[,c(1,n+1)])
				for(i in date.vec[-1]) {
					tmp           = trim(x[,c(i,i+n)])
					tmp.colnames  = colnames(tmp)
					colnames(tmp)[2] = paste(tmp.colnames[2],i,sep="")
					data.tmp = merge(data, tmp, by="Date",all=TRUE)#,incomparables=NA)
					data     = data.tmp[order(as.Date(data.tmp$Date)),]
				}
				Date.name      = data$Date
				data           = data[,-1]
				colnames(data) = x.name
				rownames(data) = Date.name
				if(xts) data   = as.xts(data)
				return(data)
			})
	return(kekka)
}
