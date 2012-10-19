	   Config { font = "-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*",
       bgColor = "black",
       fgColor = "grey",
       position = TopW L 93,
       lowerOnStart = True,
       commands = [ Run Weather "EKAH" ["-t","<station>: <tempC>C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 36000,
                    Run MultiCpu ["-L","3","-H","50","--normal","green","--high","red"] 10,
                    Run Memory ["-t","Mem: <usedratio>%"] 10,
                    Run Swap [] 10,
					Run Date "%a %b %_d %Y %H:%M:%S" "date" 10,
					Run StdinReader
                    ],
       sepChar = "%",
       alignSep = "}{",
       template = "%StdinReader% }{|%multicpu%|%memory% * %swap%|<fc=#ee9a00>%date%</fc>|%EKAH%"
       }
