#!/bin/env ruby
# encoding: utf-8

class AdminController < ApplicationController

  #before_filter { unauthorized! unless current_user.insider }

    def admin_info
      @total_users = User.count
      @total_users_this_month = User.where('created_at >= ?', 1.month.ago)
      @total_billed = EwayPayment.all.inject(0){|sum, payment| sum += payment.return_amount}
      @total_billed_this_month = EwayPayment.all.inject(0){|sum, payment| sum += payment.return_amount}
    end

end