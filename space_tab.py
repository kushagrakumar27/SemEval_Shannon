import re

file = open('friends.train.scene_delim.conll','r')
temp = ""
i=0
for lines in file:
	t =re.sub(' +',' ',lines)
	t1 = t.split(" ")
	for j in range (len(t1)-1):
		temp += t1[j] + "    "
	temp+="\n"
	print (i)
	i+=1
file = open('friends.train.scene_delim.txt','w')
file.write(temp)
