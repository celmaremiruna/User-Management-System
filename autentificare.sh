#!/bin/bash
echo -n "Nume: "
read utilizator
linie_utilizator=$(grep "$utilizator" utilizatori.csv)
if [ -z "$linie_utilizator" ]; then
    echo "Utilizatorul nu exista"
    exit 1
else
    echo "Utilizatorul exista"
fi
echo -n "Parola: "
read -s parola
echo
parola_hash=$(echo "$parola" | sha256sum | cut -d' ' -f1)
parola_stocata=$(echo "$linie_utilizator" | sed 's/ *, */,/g' | cut -d',' -f4)
if [ "$parola_hash" != "$parola_stocata" ]; then
    echo "Parola incorecta"
    exit 1
else
   echo -n "Autentificarea este"
   for i in {1..3}; do
     echo -n "."
     sleep 0.5
   done
   echo " Gata!" 
   echo "Autentificare reusita!"
    new_login=$(date '+%Y-%m-%d %H:%M:%S')
    linie_noua=$(echo "$linie_utilizator" | sed "s/[^,]*$/$new_login/")
    sed -i "s|$linie_utilizator|$linie_noua|" utilizatori.csv
    if ! grep -q "^$utilizator$" logged_in_users.txt; then
        echo "$utilizator" >> logged_in_users.txt
    fi
    home=$(echo "$linie_utilizator" | sed 's/ *, */,/g' | cut -d',' -f5)
    cd ~
    if [ -d "$utilizator" ]; then
        cd "$utilizator"
        echo "Te poti muta in $home"
    else
        echo "Directorul $home nu exista"
    fi
fi
