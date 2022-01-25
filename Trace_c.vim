" in ~/.vimrc
"add :    nmap fc :call Trace_c()<cr><cr>
function! Trace_c()
    exec "mark A"
" dir
   let curDir = getcwd()
   let dirList = split(curDir,'\/')
   let tarDirCount = 0
  for dirT_i in range(len(dirList)-1,0,-1)
      if dirList[dirT_i]=~"source.*"
         break
      endif   
      let tarDirCount+=1
  endfor 
  let tarDirT = ""
  let tarDirT = expand("%:p") 
"
" keyword
   let curLineT = getline(line("."))

   let curCol = col(".")
   let preCol_word = strpart(curLineT,curCol-2,1)

   while curCol > 1
     let preCol_word = strpart(curLineT,curCol-2,1)
     if preCol_word =~'\W'
        break
     else
       let curCol = curCol - 1
     endif

   endwhile
"   let subLineT = strpart(curLineT,col(".")-1)
   let subLineT = strpart(curLineT,curCol-1)

   echo subLineT
 let endFlag_id = match(subLineT,'\W')
"    echo endFlag_id
   let keyWord_l = strpart(subLineT,0,endFlag_id)
"   echo keyWord_l
   let keyWord = (len(a:000)>0) ? (a:000) : keyWord_l
"exe vimgrep
   if endFlag_id != 0
        exec "vimgrep "."/\\W*[_a-zA-Z0-9]\\@<!".keyWord."\\W/j ".tarDirT
        exec "cope"
   else
       echo "eer:".keyWord

      sleep 4

  endif
endfunction

