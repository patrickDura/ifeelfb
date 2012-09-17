class DashboardsController < ApplicationController
  before_filter :require_authentication

  def show
  	#get my likes
  	#@likes = current_user.profile.likes

    rest = Koala::Facebook::API.new(current_user.access_token)

    #friends like
    fql = 'SELECT page_id FROM page_fan WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = ' + current_user.identifier + ')'
    fqlFriendResult = rest.fql_query(fql)

    #myLikes
    fql = 'SELECT page_id FROM page_fan WHERE uid = ' + current_user.identifier
    fqlMeResult = rest.fql_query(fql)

    friendPage = fqlFriendResult.raw_response["data"]
    mePage = fqlMeResult.raw_response["data"]

    #my Friend Page
    h = Hash.new

    #Hash of my friends
    mePage.each do |myPage|
      h[myPage["page_id"]] = 1
    end

    #For each friends page
    friendPage.each do |page|
      unless h[page["page_id"]] == nil
        h[page["page_id"]] = h[page["page_id"]] + 1
      end
    end

    #ordering hash
    @finalResult = Hash[h.sort_by { |id, nb| nb }]

  end

end