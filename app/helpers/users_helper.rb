require 'json'
require 'spreadsheet'

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

    def download_to_excel(data_obj)
        book = Spreadsheet::Workbook.new

        sheet1 = book.create_worksheet :name => 'User Details'

        header_format = Spreadsheet::Format.new :color => :green,
                                        :weight => :bold,
                                        :size => 18

        label_format = Spreadsheet::Format.new :weight => :bold,
                                        :size => 14

        standard_format = Spreadsheet::Format.new :size => 14

        sheet1[0,0] = "User Details"
        sheet1.row(0).default_format = header_format

        sheet1[1,0] = "Pay Rate:"
        sheet1[1,1] = data_obj[:userInfo][:pay]
        sheet1[2,0] = "Pay Frequency:"
        sheet1[2,1] = data_obj[:userInfo][:payFreq]
        sheet1[3,0] = "Paycheck Hours:"
        sheet1[3,1] = data_obj[:userInfo][:hours]
        sheet1[4,0] = "No. of Deductions:"
        sheet1[4,1] = data_obj[:userInfo][:deductions]
        sheet1[5,0] = "Est. Gross:"
        sheet1[5,1] = data_obj[:userInfo][:gross]
        sheet1[6,0] = "Est. Take Home:"
        sheet1[6,1] = data_obj[:userInfo][:net]
        sheet1[7,0] = "No. Expenses:"
        sheet1[7,1] = data_obj[:userInfo][:numExpenses]
        sheet1[8,0] = "Expense Total:"
        sheet1[8,1] = data_obj[:userInfo][:totalExpenses]
        sheet1[9,0] = "Pay Start Date:"
        sheet1[9,1] = data_obj[:userInfo][:startDate]
        sheet1[10,0] = "Next Payday:"
        sheet1[10,1] = data_obj[:userInfo][:nextDate]


        sheet1[12,0] = "Master Expense List"
        sheet1.row(12).default_format = header_format
        sheet1[13,0] = "Name:"
        sheet1[13,1] = "Amount:"
        sheet1[13,2] = "Due Date:"
        sheet1.row(13).default_format = label_format

        for a in 0..data_obj[:expenses].length() -1 do
            expense = data_obj[:expenses][a]
            row_num = a + 14
            sheet1[row_num,0] = expense[:name]
            sheet1[row_num,1] = expense[:amount]
            sheet1[row_num,2] = expense[:date]
        end

        10.times do |x| sheet1.row(x + 1).set_format(0, label_format) end
        10.times do |x| sheet1.row(x + 1).set_format(1, standard_format) end
            
        (0...sheet1.column_count).each do |col_idx|
            column = sheet1.column(col_idx)
            column.width = column.each_with_index.map do |cell, row|
                chars = cell.present? ? cell.to_s.strip.split('').count + 4 : 1
                ratio = sheet1.row(row).format(col_idx).font.size / 10
                (chars * ratio).round
            end.max
        end

        for a in 14..data_obj[:expenses].length() + 14 do
            sheet1.row(a).default_format = standard_format
        end

        book.write "public/#{data_obj[:userInfo][:username]}-expense-info.xls"
    end
end
