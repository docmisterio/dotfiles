heroku auth:logout
lpass logout -f
lpass login joseph.hainline@gmail.com
touch ~/temp_logmein.txt 
lpass show --username 1954317026 >> ~/temp_logmein.txt
lpass show --password 1954317026 >> ~/temp_logmein.txt
heroku auth:login < ~/temp_logmein.txt
rm -f ~/temp_logmein.txt
