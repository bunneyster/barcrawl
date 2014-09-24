module InvitationsHelper
  def new_invitation_status(user, tour)
    return 'rejected' if tour.invitation_for(user).status == 'accepted'
    return 'accepted' if tour.invitation_for(user).status == 'pending'
    return 'accepted' if tour.invitation_for(user).status == 'rejected'
  end
  
  def rsvp_button_icon(user, tour)
    return 'sign-out fw' if tour.invitation_for(user).status == 'accepted'
    return 'sign-in fw' if tour.invitation_for(user).status == 'pending'
    return 'sign-in fw' if tour.invitation_for(user).status == 'rejected'
  end
end