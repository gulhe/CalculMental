#!/bin/bash

resFile='/tmp/calculus.results'
rm -fr $resFile

echo trève de blah blah ... T\'as 6 minutes '(pas une de plus)' pour me finir ce merdier '!!!' alors colles toi les piles, bitch '!'
read lolOsef

nbQuestions=15
startTime=$(date '+%s')
endTime=$(( $startTime + ( 1 * 60 ) ))
counter=0
while [ $(date '+%s') -lt $endTime ] && [ $counter -lt $nbQuestions ]
do
	clear
	if [ $lolOsef == "caca" ]
	then
		echo tiens ... ça m\'aurait étonné dis donc ...
	fi

	counter=$(($counter+1))
	echo 'Question '$counter' : (il reste '$(( $endTime - $(date '+%s') ))' secondes)'


	TIME_BASE=$(date '+%N')
	# Temps en nanoseconds ...
	# il faudrait etre un poil balèze pour le prédire
	# ... ce petit enculé 

	SIGN_SEED=${TIME_BASE: -5:1}
	# 5eme char en partant de la fin
	PRE_PLUS=${SIGN_SEED/[02497]/'+'} #50% des valeurs possibles donnent un +
	SIGN=${PRE_PLUS/[^+]/'*'} # les autres donnent un *

	expr=" ${TIME_BASE: -2:2} $SIGN ${TIME_BASE: -4:2}"

	#on vire les '0' de devant pour le calcul
	#sinon bash est tout nerveux
	computable=${expr//' 0'/''}

	echo "$expr"
	read reponse
	echo "$expr | $reponse | $(($computable))">>$resFile

done


echo "C'est bon c'est fini on se détend pendant que ça calcul :)"

actualEndTime=$(date '+%s')

awk  -F'|' '
	BEGIN{
		print "Here we go";
		x=0;
	}
	{
		if($2==$3){
			x++;
			print "et plus un point !";
		}else{
			print "bim le fail !";
		}
	}
	END{
		print x "/" NR," ",100*x/NR "%";
		print x "/'$nbQuestions'"," " ,100*x/'$nbQuestions' "% Effectif";
	}
	' $resFile >> $resFile

echo "en $(( $actualEndTime - $startTime )) secondes" >>$resFile

dir=calculus
mkdir ~/$dir
fileName=~/$dir/$(date '+%y-%m-%d_%Hh%M')_Calculus.result

cp $resFile $fileName
clear

tail -n3 $fileName

echo "(les résultats sont stockés dans $fileName)"
