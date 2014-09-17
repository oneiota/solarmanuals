namespace :solar do

  task :run_payments => :environment do

    User.billable.each do |user|
      @payment = EwayPayment.new
      @payment.user = user

      @payment.process_subscription!
    end
  end

  task :fix_panel_fields => :environment do

    Manual.all.each do |m|

      number = m.panels_number.to_i
      watts = m.system_watts.to_i
      if number > 0
        per_panel_watts = watts / number
        m.panels_watts = per_panel_watts
        m.save
      end

      if m.panel_string_ids.length == 0
        string = PanelString.new
        string.number = m.panels_number
        string.volts = m.system_pv_voltage
        string.amps = m.system_pv_current
        string.manual_id = m.id
        string.save
      end
    end

  end

end