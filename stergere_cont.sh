#!/bin/bash
echo "Introduceți numele contului pe care doriti sa il stergeti:"
read utilizator
linie_utilizator=$(grep ", *$utilizator, *" utilizatori.csv)
if [ -z "$linie_utilizator" ]; then
echo "Utilizatorul '$utilizator' nu exista."
exit 1
fi
echo "Esti sigur ca vrei sa stergi contul '$utilizator'? (y/n)"
read confirmare
if [ "$confirmare" != "y" ]; then
echo "Stergerea contului a fost anulata."
exit 0
fi
linie_fara_spatii=$(echo "$linie_utilizator" | sed 's/ *, */,/g')

sed -i "/, *$utilizator, */d" utilizatori.csv
echo "Linia utilizatorului a fost stearsa din utilizatori.csv."
if [ -f logged_in_users.txt ]; then
sed -i "/^$utilizator$/d" logged_in_users.txt
echo "Contul a fost eliminat din logged_in_users.txt."
fi
cd ~
if [ -d "$utilizator" ]; then
rm -rf "$utilizator"
echo "Directorul a fost sters."
else
echo "Directorul nu a fost gasit."
fi
echo "Contul "$utilizator" a fost sters complet."
