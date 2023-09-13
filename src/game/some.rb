def list_all_games
  if @games.empty?

    puts "\nNo games yet"

  else

    puts "\nGames:"

    @games.each_with_index do |game, index|
      title = game.label.title

      author = "#{game.author.fist_name[0].capitalize}. #{game.author.last_name}"

      multiplayer = game.multiplayer

      last_played_at = game.last_played_at

      output = "#{index}: TITLE: #{title} | AUTHOR: #{author} | MULTIPLAYER: #{multiplayer} |  LAST PLAYED AT: #{last_played_at} |"

      output + if game.publish_date.zero?

                 "RELEASE DATE: 'Unknown'"

               else

                 "RELEASE DATE: #{game.publish_date}"

               end
    end

  end
end
