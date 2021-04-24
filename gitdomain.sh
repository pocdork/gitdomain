#!/bin/sh

RED='\033[0;31m'
NC='\033[0m' # No Color
echo "   _____ _ _   _____                        _       ";
echo "  / ____(_) | |  __ \                      (_)      ";
echo " | |  __ _| |_| |  | | ___  _ __ ___   __ _ _ _ __  ";
echo " | | |_ | | __| |  | |/ _ \| '_ \` _ \ / _\` | | '_ \ ";
echo " | |__| | | |_| |__| | (_) | | | | | | (_| | | | | |";
echo "  \_____|_|\__|_____/ \___/|_| |_| |_|\__,_|_|_| |_|";
echo "                                                    ";
printf "\t\t\t\t𝔹𝕪 𝕊𝕠𝕦𝕣𝕒𝕧 𝕊𝕒𝕙𝕒𝕟𝕒 (${RED}@PocDork${NC})\n\n\n"                                                                                  
                                                                                  

org="$1" #Org name
intype="$2"
domain="$3" #Domain input file


printf "${RED}Getting repositories from https://github.com/$org/ ...${NC}\n\n" 
auth=$(cat .token)


	for ((n=1;n<=20;n++))
	do

 		p="$n"
 		printf "${RED}Going to page $p ...${NC}\n\n" 
 		
 		repo=$(curl -i -H "Authorization: token $auth" "https://api.github.com/users/$org/repos?per_page=100\&page=$p" -silent | grep -o 'git@[^"]*' | grep -o -P '(?<=/).*(?=.git)')
 		check=$(echo $?)
 		echo "$repo" | tee -a "./result/repo.txt"

 		if [[ "$check">0 ]]; then

 			printf "${RED}No more pages...${NC}\n\n" 
 			break
 		fi

	done

	while read dir
	do
		echo "$org.github.io/" | sed -e 's/$/'$dir'/' | tee -a "./result/tmp-pages.txt"


	done < "./result/repo.txt"


	case "$intype" in
		-t )
			echo "$domain"
			#This is for multiple domains:
			while read lines
			do

				while read repo
				do

					echo "$lines" | sed 's/^/'$repo'-/' | tee -a "./result/tmp-domains.txt"
					echo "$lines" | sed 's/^/'$repo'./' | tee -a "./result/tmp-domains.txt"


				done < "./result/repo.txt"

			done < "$domain"
			;;
		-d )
			#Its for single domain
				while read repo
				do

					echo "$domain" | sed 's/^/'$repo'./' | tee -a "./result/tmp-domains.txt"


				done < "./result/repo.txt"

			;;
		* )
			echo "Invalid Argument!"
			;;
	esac

	printf "${RED}Resolving subdomains ...${NC}\n" 
	httpx -l "./result/tmp-domains.txt" -silent --status-code -o "./result/"$domain"-resolved.txt"

	printf "${RED}Resolving GitHub pages ...${NC}\n" 
	httpx -l "./result/tmp-pages.txt" -silent -mc 301,200 -o "./result/"$domain"-github-pages-resolved.txt"
	rm "./result/tmp-domains.txt"
	rm "./result/repo.txt"
	rm "./result/tmp-pages.txt"