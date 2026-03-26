#!/bin/bash
read -p "Nume utilizator: " utilizator
if grep -q "^$utilizator$" logged_in_users.txt; then
    sed -i "/^$utilizator$/d" logged_in_users.txt
    echo "$utilizator a fost delogat."
else
    echo "Utilizatorul nu este conectat."
fi
