class PlayersController < ApplicationController
def new
#@players = Player.where(ready: false)
end

def index
zapr=" "
	if params[:goals]!=""
		zapr="goals #{params[:cond]} :goals"
	end
	if params[:ready]!="-"
		if params[:goals]!=""
			zapr=zapr+" and ready = :ready"
		else 
			zapr=zapr+" ready = :ready"
		end
	end
	if params[:name]!=""
		if params[:goals]!="" or params[:ready]!="-"
			case params[:option]
			when "equal"
				parname=params[:name]
				zapr=zapr+" and name=:name"
			when "starts_with"	
				parname="#{params[:name]}%"			
				zapr=zapr+" and name like :name"
			end
		else
			case params[:option]
			when "equal"
				parname=params[:name]
				zapr=zapr+" name=:name"
			when "starts_with"	
				parname="#{params[:name]}%"				
				zapr=zapr+" name like :name"
			end
		end
	end
	if params[:goals_or]!=""
		if params[:goals]!="" or params[:ready]!="-" or params[:name]!=""
			zapr=zapr+" or goals #{params[:cond_or]} :goals_or"
		else 
			zapr=zapr+" goals #{params[:cond_or]} :goals_or"
		end
	end
	if params[:ready_or]!="-"
		if params[:goals]!="" or params[:ready]!="-" or params[:name]!="" or params[:goals_or]!=""
			zapr=zapr+" or ready = :ready_or"
		else 
			zapr=zapr+" ready = :ready_or"
		end
	end
	if params[:name_or]!=""
		if params[:goals]!="" or params[:ready]!="-" or params[:name]!="" or params[:goals_or]!="" or params[:ready_or]!="-" 
			case params[:option_or]
			when "equal"
				parname_or=params[:name_or]
				zapr=zapr+" or name=:name_or"
			when "starts_with"	
				parname_or="#{params[:name_or]}%"			
				zapr=zapr+" or name like :name_or"
			end
		else
			case params[:option_or]
			when "equal"
				parname_or=params[:name_or]
				zapr=zapr+" name=:name_or"
			when "starts_with"	
				parname_or="#{params[:name_or]}%"				
				zapr=zapr+" name like :name_or"
			end
		end
	end
	
@players = Player.where(zapr,name: parname,ready: params[:ready],goals: params[:goals],name_or: parname_or,ready_or: params[:ready_or],goals_or: params[:goals_or])
#	if params[:goals]!=""
#		if zapr=""
#			zapr=" "+zapr+" goals #{params[:cond]} #{params[:goals]}"
#		else
#			zapr=" "+zapr" goals #{params[:cond]} #{params[:goals]} and"
#		end
#	end
#	if params[:ready]!="-"
#		if zapr=""
#			zapr=" "+zapr+" ready = #{params[:ready]}"
#		else
#			zapr=" "+zapr+" ready = #{params[:ready]} and"
#		end	
#	end
#	if params[:name]!=""
#		if zapr=""
#			case params[:option]
#			when "equal"
#				zapr=" "+zapr+" name='#{params[:name]}'"
#			when "starts_with"			
#				zapr=" "+zapr+" name like '#{params[:name]}%'"
#			end
#		else
#			case params[:option]
#			when "equal"
#				zapr=" "+zapr+" name='#{params[:name]}' and"
#			when "starts_with"			
#				zapr=" "+zapr+" name like '#{params[:name]}%' and"
#			end
#		end
	#end

#	case params[:option]
#			when "equal"
#				@players = Player.where("goals #{params[:cond]} #{params[:goals]} and ready = #{params[:ready]} and name='#{params[:name]}'")
#			when "starts_with"
#				@players = Player.where("goals #{params[:cond]} #{params[:goals]} and ready = #{params[:ready]} and name like '#{params[:name]}%'")
#		end
		
#	if params[:goals]!="" && params[:name]!="" && params[:ready]!="-"
#		case params[:option]
#			when "equal"
#				@players = Player.where("goals #{params[:cond]} :goals and ready = #{params[:ready]} and name=:name",name: params[:name],goals: params[:goals])
#			when "starts_with"
#				@players = Player.where("goals #{params[:cond]} :goals and ready = #{params[:ready]} and name like '#{params[:name]}%'",goals: params[:goals])
#		end
#		elsif params[:ready]!="-" && params[:goals]!=""
#			@players = Player.where("goals #{params[:cond]} :goals and ready = #{params[:ready]}",goals: params[:goals])
#		elsif params[:ready]!="-" && params[:name]!=""
#			case params[:option]
#				when "equal"
#					@players = Player.where("ready = #{params[:ready]} and name=:name",name: params[:name])
#				when "starts_with"
#					@players = Player.where("ready = #{params[:ready]} and name like '#{params[:name]}%'")
#			end
#		elsif params[:goals]!="" && params[:name]!=""
#			case params[:option]
#				when "equal"
#					@players = Player.where("goals #{params[:cond]} :goals and name=:name",goals: params[:goals],name: params[:name])
#				when "starts_with"
#					@players = Player.where("goals #{params[:cond]} :goals and name like '#{params[:name]}%'",goals: params[:goals])
#			end
#		elsif params[:name]!=""
#			case params[:option]
#				when "equal"
#					@players = Player.where("name=:name",name: params[:name])
#				when "starts_with"
#					@players = Player.where("name like '#{params[:name]}%'")
#			end
#		elsif params[:goals]!=""
#			@players = Player.where("goals #{params[:cond]} :goals",goals: params[:goals])
#		elsif params[:ready]!="-"
#			@players = Player.where("ready = #{params[:ready]}")
#	end
end

def show
end
 
# private
 # def player_params
 #   params.require(:player).permit(:name, :goals)
 #end
end
