json.array!(@e_invitations) do |e_invitation|
  json.extract! e_invitation, :id, :sender_id, :recipient, :tour_id
  json.url e_invitation_url(e_invitation, format: :json)
end
