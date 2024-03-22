#!/bin/bash

PSQL="psql -U freecodecamp -d number_guess -t --no-align -c"

START_GAME() {

  echo "Enter your username:"

  read USERNAME_ENTERED

  # Retrieve user_name from DB
  USERNAME=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME_ENTERED'")
  EXISTING_USER="false"

  if [[ -z $USERNAME ]]
  then
    
    # else display msg2
    echo "Welcome, $USERNAME_ENTERED! It looks like this is your first time here."
    USERNAME=$USERNAME_ENTERED

  else
    
    # If username in DB, display msg1
    GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
    BEST_GAME_TRIES=$($PSQL "SELECT best_game_tries FROM users WHERE username = '$USERNAME'")
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME_TRIES guesses."
    EXISTING_USER="true"

  fi

  # Generate secrete random number
  RANDOM_NUMBER=$(( RANDOM % 999 + 1 ))

  NUMBER_OF_GUESSES=0

  GUESS_NUMBER $RANDOM_NUMBER $USERNAME $EXISTING_USER $NUMBER_OF_GUESSES

}

GUESS_NUMBER() {

  GUESSED_NUMBER=$5

  if [[ -z $GUESSED_NUMBER ]]
  then

    # Request first guess from user
    echo "Guess the secret number between 1 and 1000:"
    read NEW_GUESS
    GUESSED_NUMBER=$NEW_GUESS

  fi

  if [[ $GUESSED_NUMBER =~ ^[[:digit:]]+$ ]]
  then

    if [[ $GUESSED_NUMBER -gt $1 ]]
    then

      echo "It's lower than that, guess again:"
      read NEW_GUESS
      GUESS_NUMBER $1 $2 $3 $(( $4 + 1 )) $NEW_GUESS

    elif [[ $GUESSED_NUMBER -lt $1 ]]
    then

      echo "It's higher than that, guess again:"
      read NEW_GUESS
      GUESS_NUMBER $1 $2 $3 $(( $4 + 1 )) $NEW_GUESS

    else

      echo "You guessed it in $(( $4 + 1 )) tries. The secret number was $1. Nice job!"
      echo $1
      echo $2
      echo $3
      echo $4

    fi

  else
    echo "That is not an integer, guess again:"
    read NEW_GUESS
    GUESS_NUMBER $1 $2 $3 $4 $NEW_GUESS
  fi

}

START_GAME