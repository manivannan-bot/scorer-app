class AllMatchesModel {
  bool? status;
  dynamic message;
  List<Matches>? matches;

  AllMatchesModel({status, message, matches});

  AllMatchesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches!.add(new Matches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (matches != null) {
      data['matches'] = matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  dynamic matchId;
  dynamic matchNumber;
  dynamic team1Id;
  dynamic team2Id;
  dynamic scorerId;
  dynamic umpireId;
  dynamic date;
  dynamic venue;
  dynamic slotStartTime;
  dynamic slotEndTime;
  dynamic organiser;
  dynamic ground;
  dynamic tossWonBy;
  dynamic choseTo;
  dynamic overs;
  dynamic currentInnings;
  dynamic matchStatus;
  dynamic matchWonBy;
  dynamic matchLossBy;
  dynamic resultDescription;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic team1Name;
  dynamic team2Name;
  dynamic tossWinnerName;
  dynamic status;
  List<Teams>? teams;

  Matches(
      {matchId,
        matchNumber,
        team1Id,
        team2Id,
        scorerId,
        umpireId,
        date,
        venue,
        slotStartTime,
        slotEndTime,
        organiser,
        ground,
        tossWonBy,
        choseTo,
        overs,
        currentInnings,
        matchStatus,
        matchWonBy,
        matchLossBy,
        resultDescription,
        createdAt,
        updatedAt,
        team1Name,
        team2Name,
        tossWinnerName,
        status,
        teams});

  Matches.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    matchNumber = json['match_number'];
    team1Id = json['team_1_id'];
    team2Id = json['team_2_id'];
    scorerId = json['scorer_id'];
    umpireId = json['umpire_id'];
    date = json['date'];
    venue = json['venue'];
    slotStartTime = json['slot_start_time'];
    slotEndTime = json['slot_end_time'];
    organiser = json['organiser'];
    ground = json['ground'];
    tossWonBy = json['toss_won_by'];
    choseTo = json['chose_to'];
    overs = json['overs'];
    currentInnings = json['current_innings'];
    matchStatus = json['match_status'];
    matchWonBy = json['match_won_by'];
    matchLossBy = json['match_loss_by'];
    resultDescription = json['result_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    team1Name = json['team1_name'];
    team2Name = json['team2_name'];
    tossWinnerName = json['toss_winner_name'];
    status = json['status'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = matchId;
    data['match_number'] = matchNumber;
    data['team_1_id'] = team1Id;
    data['team_2_id'] = team2Id;
    data['scorer_id'] = scorerId;
    data['umpire_id'] = umpireId;
    data['date'] = date;
    data['venue'] = venue;
    data['slot_start_time'] = slotStartTime;
    data['slot_end_time'] = slotEndTime;
    data['organiser'] = organiser;
    data['ground'] = ground;
    data['toss_won_by'] = tossWonBy;
    data['chose_to'] = choseTo;
    data['overs'] = overs;
    data['current_innings'] = currentInnings;
    data['match_status'] = matchStatus;
    data['match_won_by'] = matchWonBy;
    data['match_loss_by'] = matchLossBy;
    data['result_description'] = resultDescription;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['team1_name'] = team1Name;
    data['team2_name'] = team2Name;
    data['toss_winner_name'] = tossWinnerName;
    data['status'] = status;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  dynamic teamName;
  dynamic totalRuns;
  dynamic totalWickets;
  dynamic ballNumber;
  dynamic overNumber;
  dynamic currentOverDetails;

  Teams(
      {teamName,
        totalRuns,
        totalWickets,
        ballNumber,
        overNumber,
        currentOverDetails});

  Teams.fromJson(Map<String, dynamic> json) {
    teamName = json['team_name'];
    totalRuns = json['total_runs'];
    totalWickets = json['total_wickets'];
    ballNumber = json['ball_number'];
    overNumber = json['over_number'];
    currentOverDetails = json['current_over_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_name'] = teamName;
    data['total_runs'] = totalRuns;
    data['total_wickets'] = totalWickets;
    data['ball_number'] = ballNumber;
    data['over_number'] = overNumber;
    data['current_over_details'] = currentOverDetails;
    return data;
  }
}
