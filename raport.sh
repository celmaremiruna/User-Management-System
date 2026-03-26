#!/bin/bash
echo "Introduceti numele utilizatorului:"
read nume
linie=$(grep ", $nume," utilizatori.csv)
if [ -z "$linie" ]; then
echo "Utilizatorul nu exista."
exit 1
fi
cd ~
if [ ! -d "$nume" ]; then
echo "Directorul home nu exista."
exit 1
fi
raport="$nume/raport.txt"
nr_fisiere=$(find "$nume" -type f | wc -l)
nr_directoare=$(find "$nume" -type d | wc -l)
dimensiune=$(du -sh "$nume" 2>/dev/null | cut -f1)
data_generare=$(date "+%Y-%m-%d %H:%M:%S")
echo "Raport pentru utilizatorul $nume" > "$raport"
echo "Numar fisiere: $nr_fisiere" >> "$raport"
echo "Numar directoare: $nr_directoare" >> "$raport"
echo "Dimensiune: $dimensiune" >> "$raport"
echo "Generat la: $data_generare" >> "$raport"
echo "Raport generat in $raport"

