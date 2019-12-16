module MainHelper

  def sort_teams(teams)
    if teams.length < 2
      return teams
    else
      pivot = teams[rand(teams.length)]

      less = []
      greater = []
      (teams - [pivot]).each do |team| 
        if team[:victorious_team]["score"] > pivot[:victorious_team]["score"]
          greater << team
        else
          less << team
        end
      end

      return sort_teams(greater) + [pivot] + sort_teams(less)
    end
  end

  def convert_date(date)
    return "#{Date::MONTHNAMES[date.month.to_i]} #{date.day}, #{date.year}"
  end
end
