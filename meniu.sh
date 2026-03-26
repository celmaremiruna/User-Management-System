#!/bin/bash
CSV_FILE="utilizatori.csv"
SCRIPT_LOGARE="logare.sh"
SCRIPT_AUTH="autentificare.sh"
SCRIPT_RAPORT="raport.sh"
SCRIPT_STERGERE="stergere_cont.sh"
LOGGED_IN_FILE="logged_in_users.txt"
for script in "$SCRIPT_LOGARE" "$SCRIPT_AUTH" "$SCRIPT_RAPORT" "$SCRIPT_STERGERE"; do
  if [ ! -x "$script" ]; then
    chmod +x "$script"
    if [ $? -ne 0 ]; then
      echo "Nu am putut face '$script' executabil."
      exit 1
    fi
  fi
done

touch "$LOGGED_IN_FILE"
while true; do
echo ""
echo " Meniu Principal "
echo "1. Inregistrare utilizator"
echo "2. Autentificare"
echo "3. Generare raport"
echo "4. Logout"
echo "5. Afisare utilizatori autentificati"
echo "6. Iesire"
echo "7. Stergere cont"
echo -n "Alegeti o optiune [1-7]: "
read opt
if [ "$opt" == "1" ]; then
bash "$SCRIPT_LOGARE"
elif [ "$opt" == "2" ]; then
bash "$SCRIPT_AUTH"
elif [ "$opt" == "3" ]; then
bash "$SCRIPT_RAPORT"
elif [ "$opt" == "4" ]; then
echo -n "Introduceti numele de utilizator pentru logout: "
read nume_logout
if grep -q "^$nume_logout$" "$LOGGED_IN_FILE"; then
sed -i "/^$nume_logout$/d" "$LOGGED_IN_FILE"
echo "Utilizatorul '$nume_logout' a fost delogat."
else
echo "Utilizatorul '$nume_logout' nu este autentificat."
fi
elif [ "$opt" == "5" ]; then
if [ -s "$LOGGED_IN_FILE" ]; then
echo "Utilizatori autentificati:"
cat "$LOGGED_IN_FILE"
else
echo "Niciun utilizator autentificat."
fi
elif [ "$opt" == "6" ]; then
echo "Iesire din aplicație. La revedere!"
for i in {1..3}; do
    echo -n "."
    sleep 0.5
  done
exit 0
elif [ "$opt" == "7" ]; then
bash "$SCRIPT_STERGERE"

else
echo "Optiune invalida. Reincercati."
fi
done
