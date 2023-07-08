module UsersHelper
    def get_next_paycheck(dateStr, freq)
        og_date = Date::strptime(dateStr, "%Y-%m-%d")
        today = DateTime.now
        diff = today.mjd - og_date.mjd
        new_month = today.mon + 1
        year = today.year

        if new_month > 12
            new_month = new_month - 12
            year = year + 1
        end

        if freq == "weekly"
            dateDiff = 7
        elsif freq == "bi-weekly"
            dateDiff = 14
        else
            dateDiff = 0
        end

        if dateDiff != 0 
            if diff <= 0
                calc = dateDiff
            elsif diff % dateDiff == 0
                calc = diff
            else
                calc = (dateDiff - (diff % dateDiff)) + diff
            end
            new_pay_day = og_date + calc
        elsif freq == "monthly"
            if today > og_date
                if today.mday == 1
                    new_pay_day = today
                else
                    a_month_later = today + 1.months
                    new_month = a_month_later.mon
                    new_year = a_month_later.year
                    new_date_str = "#{new_year}-#{new_month}-01"
                    new_pay_day = Date::strptime(new_date_str, "%Y-%m-%d")
                end
            else
                next_month = og_date + 1.months
                new_month = next_month.mon
                new_year = next_month.year
                new_date_str = "#{new_year}-#{new_month}-01"
                new_pay_day = Date::strptime(new_date_str, "%Y-%m-%d")
            end
        elsif freq == "bi-monthly"
            if today > og_date
                if today.mday == 1 || today.mday == 15
                    new_pay_day = today
                else
                    if today.mday > 15
                        a_month_later = today + 1.months
                        new_month = a_month_later.mon
                        new_year = a_month_later.year
                        new_date_str = "#{new_year}-#{new_month}-01"
                        new_pay_day = Date::strptime(new_date_str, "%Y-%m-%d")
                    else
                        new_month = today.mon
                        new_year = today.year
                        new_date_str = "#{new_year}-#{new_month}-15"
                        new_pay_day = Date::strptime(new_date_str, "%Y-%m-%d")
                    end
                end
            else
                if og_date.mday >= 15
                    next_month = og_date + 1.months
                    new_month = next_month.mon
                    new_year = next_month.year
                    new_date_str = "#{new_year}-#{new_month}-01"
                    new_pay_day = Date::strptime(new_date_str, "%Y-%m-%d")
                else
                    new_month = og_date.mon
                    new_year = og_date.year
                    new_date_str = "#{new_year}-#{new_month}-15"
                    new_pay_day = Date::strptime(new_date_str, "%Y-%m-%d")
                end
            end
        end

        return new_pay_day.to_s
    end
end
