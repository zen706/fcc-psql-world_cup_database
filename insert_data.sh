#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
  echo $($PSQL "TRUNCATE TABLE games, teams")

  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    # the first title line should be discarded
    if [[ $YEAR != year ]]
    then
      # echo $YEAR $ROUND $WINNER $OPPONENT $WINNER_GOALS $OPPONENT_GOALS
      # get WINNER_ID
      WINNER_ID=$($PSQL "SELECT team_id FROM teams where name='$WINNER'")

      # if not found
      if [[ -z $WINNER_ID ]]
      then
        # insert winner into teams
        INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) values('$WINNER')")
        if [[ $INSERT_WINNER_RESULT = "INSERT 0 1" ]]
        then
          echo inserted into teams, $WINNER
        fi
        # get new WINNER_ID
        WINNER_ID=$($PSQL "SELECT team_id FROM teams where name='$WINNER'")
      fi

      # get opponent_id
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams where name='$OPPONENT'")

      # if not found
      if [[ -z $OPPONENT_ID ]]
      then
        # insert winner into teams
        INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) values('$OPPONENT')")
        if [[ $INSERT_OPPONENT_RESULT = "INSERT 0 1" ]]
        then
          echo inserted into teams, $OPPONENT
        fi
        # get new OPPONENT_ID
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams where name='$OPPONENT'")
      fi

      # echo "$WINNER_ID,$OPPONENT_ID"

      # Insert into games
      INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND',$WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
      if [[ $INSERT_GAMES_RESULT = "INSERT 0 1" ]]
      then
        echo Inserted into gamse, $YEAR, $ROUND,$WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS
      fi

    fi
  done  

else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
  echo $($PSQL "TRUNCATE TABLE games, teams")
   
  # same lines as above
  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    # the first title line should be discarded
    if [[ $YEAR != year ]]
    then
      # echo $YEAR $ROUND $WINNER $OPPONENT $WINNER_GOALS $OPPONENT_GOALS
      # get WINNER_ID
      WINNER_ID=$($PSQL "SELECT team_id FROM teams where name='$WINNER'")

      # if not found
      if [[ -z $WINNER_ID ]]
      then
        # insert winner into teams
        INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) values('$WINNER')")
        if [[ $INSERT_WINNER_RESULT = "INSERT 0 1" ]]
        then
          echo inserted into teams, $WINNER
        fi
        # get new WINNER_ID
        WINNER_ID=$($PSQL "SELECT team_id FROM teams where name='$WINNER'")
      fi

      # get opponent_id
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams where name='$OPPONENT'")

      # if not found
      if [[ -z $OPPONENT_ID ]]
      then
        # insert winner into teams
        INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) values('$OPPONENT')")
        if [[ $INSERT_OPPONENT_RESULT = "INSERT 0 1" ]]
        then
          echo inserted into teams, $OPPONENT
        fi
        # get new OPPONENT_ID
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams where name='$OPPONENT'")
      fi

      # echo "$WINNER_ID,$OPPONENT_ID"

      # Insert into games
      INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND',$WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
      if [[ $INSERT_GAMES_RESULT = "INSERT 0 1" ]]
      then
        echo Inserted into gamse, $YEAR, $ROUND,$WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS
      fi


    fi
  done

fi

# Do not change code above this line. Use the PSQL variable above to query your database.
