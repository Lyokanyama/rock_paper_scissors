VALID_CHOICES = %w(rock paper scissors spock lizard)
WIN_CONDITIONS = { 'lizard' => %w[spock paper],
                   'paper' => %w[rock spock],
                   'scissors' => %w[paper lizard],
                   'rock' => %w[scissors lizard],
                   'spock' => %w[scissors rock] }

def prompt(message)
  puts("=> #{message}")
end

def win?(player, computer)
  if WIN_CONDITIONS[player].include?(computer)
    true
  end
end

def display_round_results(player, computer)
  if win?(player, computer)
    prompt("You win the round!")
  elsif win?(computer, player)
    prompt("You lose the round!")
  else
    prompt("The round was a tie!")
  end
end

def choice_shortcut(choice)
  case choice
  when "r" then "rock"
  when "p" then "paper"
  when "sc" then "scissors"
  when "s" then "spock"
  when "l" then "lizard"
  end
end

def increment_score(first, second)
  if win?(first, second)
    1
  else
    0
  end
end

def display_winner(player_score, computer_score)
  if player_score == 5
    prompt("You win! Your score was #{player_score} to #{computer_score}")
  elsif computer_score == 5
    prompt("You lost! Your score was #{player_score} to #{computer_score}")
  end
end

def display_scores(player_score, computer_score)
  prompt("Your score is #{player_score} to #{computer_score}")
end

loop do # Program loop
  choice = nil

  player_score = 0
  computer_score = 0

  loop do # Game loop
    loop do # player input loop
      prompt("Choose one: (r)ock, (p)aper, (sc)issors, (s)pock, (l)izard")
      choice = gets.chomp.downcase

      if choice.length == 1
        choice = choice_shortcut(choice)
      end

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose #{choice}; Computer chose: #{computer_choice}")

    player_score += increment_score(choice, computer_choice)
    computer_score += increment_score(computer_choice, choice)

    display_round_results(choice, computer_choice)

    if player_score < 5 && computer_score < 5
      display_scores(player_score, computer_score)
    end

    display_winner(player_score, computer_score)

    if player_score == 5 || computer_score == 5
      break
    end
  end
  print("\n")
  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
