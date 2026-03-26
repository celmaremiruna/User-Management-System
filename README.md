# Bash User Management System

## Overview
This project is a simulated User Management System built entirely with Bash scripting for a Linux environment. It was developed collaboratively as a team project. It provides a terminal-based menu interface handling user registration, secure authentication, session management, and asynchronous system reporting using standard Linux tools.

## Features

* **User Registration (`autentificare.sh`):**
  * Checks for username availability.
  * Collects user details (email, password).
  * Hashes passwords securely using `sha256sum` before storing them (no plain-text passwords).
  * Auto-generates a unique ID and creates a dedicated "home" directory for the new user.
  * Appends the new user record to the `utilizatori.csv` registry.
  * Sends a confirmation email (simulated/using `sendmail`) upon successful registration.

* **User Authentication & Logout (`logare.sh` & `logout.sh`):**
  * Prompts for username and password.
  * Verifies credentials by comparing the input hash with the stored hash in the CSV registry.
  * Upon successful login, updates the `last_login` field in the registry, navigates the terminal to the user's home directory, and adds the username to a `logged_in_users.txt` session array.
  * The logout functionality securely removes the active user from the logged-in list.

* **Asynchronous Reporting (`raport.sh`):**
  * Generates a detailed report for a specified user, counting the total number of files, directories, and the total disk space utilized by their home directory.
  * The report generation runs asynchronously in the background.
  * Output is automatically saved inside the respective user's home directory.

* **Account Deletion (`stergere_cont.sh`):**
  * Removes the user's data from the system and updates the registry accordingly.

## File Structure
* `meniu.sh` - The main entry point containing the interactive menu.
* `autentificare.sh` - Handles new user registration.
* `logare.sh` - Handles secure login and session creation.
* `logout.sh` - Ends the user session.
* `raport.sh` - Asynchronous resource reporting script.
* `stergere_cont.sh` - Deletes user accounts.
* `utilizatori.csv` - The main registry/database storing IDs, usernames, emails, password hashes, and last login timestamps.
* `logged_in_users.txt` - Tracks currently active user sessions.
* `email.txt` - Email templates or logs for the registration process.

## Usage
Run the main menu script to interact with the system:
```bash
./meniu.sh
