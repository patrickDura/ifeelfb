class DashboardsController < ApplicationController
  before_filter :require_authentication

  def show
  	#get my likes
  	#@likes = current_user.profile.likes

    rest = Koala::Facebook::API.new(current_user.access_token)

    #friends like
    fql = 'SELECT uid, page_id FROM page_fan WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = ' + current_user.identifier + ')'
    fqlFriendResult = rest.fql_query(fql)

    #myLikes
    fql = 'SELECT page_id FROM page_fan WHERE uid = ' + current_user.identifier
    fqlMeResult = rest.fql_query(fql)

    friendPage = fqlFriendResult.raw_response["data"]
    mePage = fqlMeResult.raw_response["data"]

    #Hash of my friends
    h = Hash.new
    @finalResult = Hash.new
    mePage.each do |myPage|
      h[myPage["page_id"]] = []
    end

    #For each friends page
    friendPage.each do |page|
      unless h[page["page_id"]] == nil
        @finalResult[page["page_id"]] = h[page["page_id"]] << page["uid"]
      end
    end

    #ordering hash
    #@finalResult = h #Hash[h.sort_by { |id, nb| nb }]

  end

end