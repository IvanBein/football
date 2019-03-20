class WelcomeController < ApplicationController
  def index
    parname = param_name(params[:option], params[:name])
    request = func_req(params[:goals], params[:cond], params[:ready], params[:name], '')

    if (params[:goals_or] != '') || (params[:name_or] != '') || (params[:ready_or] != '-')
      request = there_is_or(request)
      parname_or = param_name(params[:option_or], params[:name_or])
    end

    if !params[:goals].nil?
      @players = Player.where(request, name: parname, ready: params[:ready], goals: params[:goals], name_or: parname_or, ready_or: params[:ready_or], goals_or: params[:goals_or]).limit(20)
    else
      @players = Player.all.limit(20)
    end
  end

  def there_is_or(request)
    if (params[:goals] != '') || (params[:name] != '') || (params[:ready] != '-')
      request += ' or ' + func_req(params[:goals_or], params[:cond_or], params[:ready_or], params[:name_or], '_or')
    else
      request += func_req(params[:goals_or], params[:cond_or], params[:ready_or], params[:name_or], '_or')
    end
    request
  end

  def option_name(request, and_text, prefix)
    case params[:option]
    when 'equal'
      request = request + and_text + ' name=:name' + prefix
    when 'starts_with'
      request = request + and_text + ' name like :name' + prefix
    end
    request
  end

  def param_name(option, name)
    case option
    when 'equal'
      parname = name
    when 'starts_with'
      parname = "#{name}%"
    end
    parname
  end

  def func_req(goals, cond, ready, name, prefix)
    request = ''
    if goals != ''
      case cond
      when '>'
        request = 'goals > :goals' + prefix
      when '<'
        request = 'goals < :goals' + prefix
      when
        request = 'goals = :goals' + prefix
      end
    end

    if ready != '-'
      request = if goals != ''
                  request + ' and ready = :ready' + prefix
                else
                  request + ' ready = :ready' + prefix
                end
      end

    if name != ''
      request = if (goals != '') || (ready != '-')
                  option_name(request, ' and ', prefix)
                else
                  option_name(request, '', prefix)
                end
      end
    request
  end
end