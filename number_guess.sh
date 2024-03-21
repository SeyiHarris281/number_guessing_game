#!/bin/bash

PSQL="psql -U freecodecamp -d number_guess -t --no-align -c"

START_GAME() {

  echo "Enter your username:"

  read USER_NAME_ENTERED

  # Retrieve user_name from DB
  # If in DB, display msg1
  # else display msg2
  # Generate secrete random number
  # Request guess from user
  # If guess > target, display msg 1 and loop
  # If guess < target, display msg 2 and loop
  # If guess = target, display msg 3 and update DB
  # end game

}

START_GAME