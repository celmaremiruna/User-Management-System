#!/bin/bash
introducere_parola() {
echo "Introduceti parola (minim 6 caractere): "
read -s parola1
echo "Confirmati parola: "
read -s parola2
}
echo "Introduceti numele de utilizator(fara majuscule sau spatii): "
read nume
if grep -q "^[^,]*, $nume," utilizatori.csv; then
echo "Acest utilizator exista deja. Alegeti optiunea de autentificare."
else
echo "Introduceti adresa de email: "
read email
while [ ${#parola1} -lt 6 ]; do
  echo "Parola trebuie sa aiba minim 6 caractere."
  introducere_parola
done
while [ "$parola1" != "$parola2" ]; do
  echo "Parolele nu coincid. Incercati din nou."
  introducere_parola
  while [ ${#parola1} -lt 6 ]; do
    echo "Parola trebuie sa aiba minim 6 caractere."
    introducere_parola
    done
  done
parola_hash=$(echo "$parola1" | sha256sum | cut -d' ' -f1)
id=$(head /dev/urandom | tr -dc 0-9 | head -c 4)
home="~/$nume"
last_login=$(date "+%Y-%m-%d %H:%M:%S")
HOSTNAME=$(hostname)
if [[ "$HOSTNAME" == "sop.ase.ro" ]]; then
echo "Inregistrarea se efectueaza de pe serverul facultatii si nu se va putea trimite un mail de confirmare."
for i in {1..3}; do
    echo -n "."
    sleep 0.5
  done
else
sendmail "$email" < email.txt
fi
echo -e "\n$id, $nume, $email, $parola_hash, $home, $last_login" >> utilizatori.csv
cd ~
mkdir "$nume"
echo "Inregistrarea a fost efectuata cu succes!"
fi
