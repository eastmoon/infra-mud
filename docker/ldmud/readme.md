# 編譯與啟動程序

LDMud 是一套基於 LPMud 框架設計的遊戲驅動 ( Game Driver )，其設計目的是整理一個乾淨且模組化的 LPMud，而繼承 LPMud 的設計原則，在建構服務時共有兩個步驟：

+ 複製 mudlib
```
mkdir /app
cd /usr/src/ldmud/mud/lp-245
cp -r . /app
```

+ 編譯 LDMud 遊戲驅動
```
cd /usr/src/ldmud/src
./autogen.sh
./configure --libdir=/app
make install-all
```

完成上述程序後，LDMud 會被安裝置預設位置 ```/usr/local/mud/``` 下，而 MUD 內容本體放置設定於 ```/app```，便可執行下述指令啟動服務

```
/usr/local/mud/bin/ldmud 5000
```
> 5000 為 MUD 啟動後對應的連接埠
