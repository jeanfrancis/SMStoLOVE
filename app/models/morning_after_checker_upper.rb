class MorningAfterCheckerUpper
  @queue = :morning_after

  def self.perform(args_hash)
    meetup_id = args_hash["meetup_id"]

    if ! Meetup.exists?(meetup_id)
      ### TODO: untested
      raise "MorningAfterCheckerUpper ran for meetup_id #{args_hash["meetup_id"]} but could not find that meetup"
    end

    meetup = Meetup.find(meetup_id)

    meetup.first_user.tell(
      "Hey #{meetup.first_user.name}, how did it go last night with #{meetup.second_user.name}?  Respond to this text to let us know.")

    meetup.second_user.tell(
      "Hey #{meetup.second_user.name}, how did it go last night with #{meetup.first_user.name}?  Respond to this text to let us know.")

    Dfln.create(:meetup => meetup, :user => meetup.first_user,  :text => nil)
    Dfln.create(:meetup => meetup, :user => meetup.second_user, :text => nil)
  end
end
