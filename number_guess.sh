#!/bin/bash

PSQL="psql -U freecodecamp -d number_guess -t --no-align -c"

START_GAME() {

  echo "Enter your username:"

  read USERNAME_ENTERED

  # Retrieve user_name from DB
  USERNAME=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME_ENTERED'")

  if [[ -z $USERNAME ]]
  then
    
    # else display msg2
    echo "Welcome, $USERNAME_ENTERED! It looks like this is your first time here."

  else
    
    # If username in DB, display msg1
    GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
    BEST_GAME_TRIES=$($PSQL "SELECT best_game_tries FROM users WHERE username = '$USERNAME'")
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME_TRIES guesses."

  fi

  # Generate secrete random number
  RANDOM_NUMBER=$(( RANDOM % 1001 ))

  GUESS_NUMBER $RANDOM_NUMBER $USERNAME $USERNAME_ENTERED

}

GUESS_NUMBER() {

  # Request guess from user
  echo "Guess the secret number between 1 and 1000:"
  read GUESSED_NUMBER

  echo $GUESSED_NUMBER
  # If guess > target, display msg 1 and loop
  # If guess < target, display msg 2 and loop
  # If guess = target, display msg 3 and update DB
  # end game

}

START_GAME