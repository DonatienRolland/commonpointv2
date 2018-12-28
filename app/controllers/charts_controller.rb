class ChartsController < ApplicationController
  before_action :set_user, only: [ :visitors_by_months, :visitors_by_days, :visitors_by_weeks, :switchPeriod]
  skip_before_action :verify_authenticity_token, only: [:switchPeriod]
  # set ajax sur le bouton du form pour changer l'url
  def switchPeriod
    if params[:periode] == "année"
      visitors_by_months
    elsif params[:periode] == "mois"
      visitors_by_weeks
    elsif params[:periode] == "personnalisé"
      p "params[:presonnalize_date] =>>>> #{params[:presonnalize_date]}"
      dates = params[:presonnalize_date]
      if dates.present?
        @start = Date.parse(dates.split(' to ')[0])
        p "start at :#{ @start}"
        @end = Date.parse(dates.split(' to ')[1])
        p "end at :#{ @end}"
        rang = (@end-@start).to_i
        p "rang is at: #{ rang}"
        if rang < 8
          charts_visitors_by_days_path(params1: @start, params2: @end)
        elsif rang < 31

          charts_visitors_by_weeks_path

        else
          visitors_by_months
        end
      end
    else
      charts_visitors_by_days_path
    end

  end

  def visitors_by_months
    @start = Date.today.beginning_of_year
    @end = Date.today.end_of_year
    render json: Visit.where(company_id: @company.id).from_to(@start, @end).group_by_month_of_year(:created_at).count.map{ |k, v| [I18n.t("date.month_names")[k], v]}, title:"Utilisateurs Actifs"
  end
  def visitors_by_days
    @start = Date.today.beginning_of_week
    @end = Date.today.end_of_week
    render json: Visit.where(company_id: @company.id).from_to(@start, @end).group_by_day_of_week(:created_at).count.map{ |k, v| [I18n.t("date.day_names")[k], v]}
  end
  def visitors_by_weeks
    p 'ok chart semaines'
    p "#{params}"
    p "#{params[:starting]}"
    p "Je suis dans les params de weeks pour faire les start et end #{params[:starting]}"
    @start = params[:starting].present? ? Date.parse(params[:starting]) : Date.today.at_beginning_of_month
    @end = params[:ending].present? ? Date.parse(params[:ending]) : Date.today.at_beginning_of_month.next_month
    p "#{@start}"
    render json: Visit.where(company_id: @company.id).from_to(@start, @end).group_by_week(:created_at, format: "%d %B %Y").count
  end

  private



  def set_user
    @user = current_user
    @company = @user.company
    authorize @user
  end
end
