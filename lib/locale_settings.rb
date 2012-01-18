module LocaleSettings
  def self.included(klass)
    klass.instance_eval do
      before_filter :set_locale_from_params
    end
  end

  private
  def valid_locale?(locale)
    [:en, :pl].include? locale.to_sym
  end

  def default_url_options
    if valid_locale? params[:locale]
      { :locale => params[:locale] }
    else
      {  }
    end
  end

  def set_locale_from_params
    if valid_locale? params[:locale]
      I18n.locale = params[:locale]
    end
  end
end