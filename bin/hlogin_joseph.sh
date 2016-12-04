heroku auth:logout
lpass logout -f
lpass login joseph.hainline@gmail.com
touch ~/temp_logmein.txt 
lpass show --username 1671913686 >> ~/temp_logmein.txt
lpass show --password 1671913686 >> ~/temp_logmein.txt
heroku auth:login < ~/temp_logmein.txt
rm -f ~/temp_logmein.txt
