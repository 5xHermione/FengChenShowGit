# class Api::V1::IssuesController < ApplicationController
#     def favorite
#       issue = Issue.find(params[:id])
  
#       if issue.favorited_by(current_user)
#         current_user.issues.delete(issue)
#         render json: {status: 'removed'}
#       else
#         current_user.issues << issue
#         render json: {status: 'favorited'}
#       end
#     end
#   end
  
  # <%# close製作 %>