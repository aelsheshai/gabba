module Gabba
  class Gabba
    module Event
      # Public: Record an event in Google Analytics
      # (http://code.google.com/apis/analytics/docs/gaJS/gaJSApiEventTracking.html)
      #
      # category  -
      # action    -
      # label     -
      # value     -
      # utmni     -
      # utmhid    -
      #
      # Example:
      #
      #   g = Gabba::Gabba.new("UT-1234", "mydomain.com")
      #   g.event("Videos", "Play", "ID", "123", true)
      #
      def event(category, action, label = nil, value = 1, utmni = false, utmhid = random_id)
        check_account_params
        hey(event_params(category, action, label, value, utmni, utmhid))
      end

      # Public: Renders event params data in the format needed for GA
      # Called before actually sending the data along to GA in Gabba#event
      def event_params(category, action, label = nil, value = 1 , utmni = false, utmhid = false)
        raise ArgumentError.new("utmni must be a boolean") if (utmni.class != TrueClass && utmni.class != FalseClass)
        raise ArgumentError.new("value must be integer > 0 or nil") if ( value.to_i == 0 ) # value >1 required.
        {

          # unless @v.present? # Conditional setting of variables
          # :utmwv => @utmwv,
          # :utmn => @utmn,
          # :utmhn => @utmhn,
          # :utmni => (1 if utmni), # 1 for non interactive event, excluded from bounce calcs
          # :utmt => 'event',
          # :utme => "#{event_data(category, action, label, value)}#{custom_var_data}",
          # :utmcs => @utmcs,
          # :utmul => @utmul,
          # :utmhid => utmhid,
          # :utmac => @utmac,
          # :utmcc => @utmcc || cookie_params,
          # :utmr => @utmr,
          # :utmip => @utmip,
          # :utme => self.custom_var_data
          # end

          :v => @v,
          :tid => @tid,
          :cid => @cid,
          :t => 'event',
          :ec => category,
          :ea => action,
          :el => label,
          :ev => value,
          :an => @an, # MUST be included in parameters but does NOT have to be defined.
          :aid => @aid,
          :av => @av,
          :aiid => @aiid
        }
      end

      # Public: Renders event individual param data in the format needed for GA
      # Called before actually sending the data along to GA in Gabba#event
      def event_data(category, action, label = nil, value = nil)
        data = "5(#{category}*#{action}" + (label ? "*#{label})" : ")")
        data += "(#{value})" if value
        data
      end
    end
  end
end
