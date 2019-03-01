module ApplicationHelper


    def render_errors
        if flash[:errors]
            flash[:errors].each{ |error| puts error }
        end
    end

    def authentic
        "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'>".html_safe
    end
end
