module VotesHelper
  def voting_line_item_li_class(tour_stop)
    if tour_stop.upvoted_by(@current_user)
      'tour-stop-upvoted'
    elsif tour_stop.downvoted_by(@current_user)
      'tour-stop-downvoted'
    else
      'tour-stop-notvoted'
    end
  end
end
