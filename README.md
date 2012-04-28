RBloomberg
==========
ExcelのBloombergアドオンで取得したcsvデータを日付を基準としてマージする関数

xtsオプションをTRUEにすると出力がxtsになります。
xtsオプションを有効にする場合xtsライブラリを読み込んでおいて下さい。

    install.packages("xts")
    library(xts)

時系列を扱う場合xtsにすると扱いやすいです。


## Extra
Have R above version 2.14, you can compiler package.

    library(compiler)
    BB.marge.c <- cmpfun(BB.marge)
    BB.marge.c("hoge.csv")

Maybe execution speed may be a little faster.