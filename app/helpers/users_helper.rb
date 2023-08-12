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
        File.delete(*Dir.glob('public/*.xls'))

        book = Spreadsheet::Workbook.new

        sheet1 = book.create_worksheet :name => 'User Details'

        header_format = Spreadsheet::Format.new :color => :green,
                                                :weight => :bold,
                                                :size => 18

        subheader_format = Spreadsheet::Format.new :color => :blue,
                                                :weight => :bold,
                                                :size => 16

        label_format = Spreadsheet::Format.new :weight => :bold,
                                                :size => 14

        standard_format = Spreadsheet::Format.new :size => 14

        if data_obj[:userInfo][:income] == 1
            sheet1[0,0] = "Pay Details"
            sheet1.row(0).default_format = header_format
            
            sheet1[1,0] = "Next Payday:"
            sheet1[1,1] = data_obj[:userInfo][:nextDate]

            sheet1[2,0] = "Est. Monthly Pay:"
            sheet1[2,1] = data_obj[:userInfo][:monthly]

            sheet1[3,0] = "Pay Rate:"
            sheet1[3,1] = data_obj[:userInfo][:pay]

            sheet1[4,0] = "Pay Frequency:"
            sheet1[4,1] = data_obj[:userInfo][:frequency]

            sheet1[5,0] = "Paycheck Hours:"
            sheet1[5,1] = data_obj[:userInfo][:hours]

            sheet1[6,0] = "Est. Gross:"
            sheet1[6,1] = data_obj[:userInfo][:gross]

            sheet1[7,0] = "No. of Deductions:"
            sheet1[7,1] = data_obj[:userInfo][:deductions]

            sheet1[8,0] = "Est. Federal Taxes:"
            sheet1[8,1] = data_obj[:userInfo][:fed]

            sheet1[9,0] = "Est. Local Taxes:"
            sheet1[9,1] = data_obj[:userInfo][:local]

            sheet1[10,0] = "Est. Take Home:"
            sheet1[10,1] = data_obj[:userInfo][:net]

            10.times do |x| sheet1.row(x + 1).set_format(0, label_format) end
            10.times do |x| sheet1.row(x + 1).set_format(1, standard_format) end

            sheet1[12,0] = "Master Expense List"
            sheet1.row(12).default_format = header_format

            sheet1[13,0] = "No. Expenses:"
            sheet1[13,1] = data_obj[:userInfo][:numExpenses]
            
            sheet1[14,0] = "Expense Total:"
            sheet1[14,1] = data_obj[:userInfo][:totalExpenses]

            2.times do |x| sheet1.row(x + 13).set_format(0, label_format) end
            2.times do |x| sheet1.row(x + 13).set_format(1, standard_format) end

            sheet1[16,0] = "Name:"
            sheet1[16,1] = "Amount:"
            sheet1[16,2] = "Due Date:"
            sheet1.row(16).default_format = label_format

            for a in 0..data_obj[:expenses].length() -1 do
                expense = data_obj[:expenses][a]
                row_num = a + 17
                sheet1[row_num,0] = expense[:name]
                sheet1[row_num,1] = "$#{expense[:amount]}"
                sheet1[row_num,2] = expense[:date]
            end

            for a in 17..data_obj[:expenses].length() + 17 do
                sheet1.row(a).default_format = standard_format
            end
                
            (0...sheet1.column_count).each do |col_idx|
                column = sheet1.column(col_idx)
                column.width = column.each_with_index.map do |cell, row|
                    chars = cell.present? ? cell.to_s.strip.split('').count + 4 : 1
                    ratio = sheet1.row(row).format(col_idx).font.size / 12
                    (chars * ratio).round
                end.max
            end       
        else
            puts "hello?"
            sheet1[0,0] = "Pay Details"
            sheet1.row(0).default_format = header_format

            sheet1[1,0] = "Next Payday:"
            sheet1[1,1] = data_obj[:userInfo][:nextDate]

            sheet1[2,0] = "Est. Monthly Pay:"
            sheet1[2,1] = data_obj[:userInfo][:monthly]

            2.times do |x| sheet1.row(x + 1).set_format(0, label_format) end
            2.times do |x| sheet1.row(x + 1).set_format(1, standard_format) end

            sheet1[4,0] = "Paycheck 1"
            sheet1[4,3] = "Paycheck 2"
            sheet1.row(4).default_format = subheader_format

            sheet1[5,0] = "Pay Rate:"
            sheet1[5,1] = data_obj[:userInfo][:pay]
            sheet1[5,3] = "Pay Rate:"
            sheet1[5,4] = data_obj[:userInfo][:pay2]

            sheet1[6,0] = "Pay Frequency:"
            sheet1[6,1] = data_obj[:userInfo][:frequency]
            sheet1[6,3] = "Pay Frequency:"
            sheet1[6,4] = data_obj[:userInfo][:frequency2]

            sheet1[7,0] = "Paycheck Hours:"
            sheet1[7,1] = data_obj[:userInfo][:hours]
            sheet1[7,3] = "Paycheck Hours:"
            sheet1[7,4] = data_obj[:userInfo][:hours2]

            sheet1[8,0] = "Est. Gross:"
            sheet1[8,1] = data_obj[:userInfo][:gross]
            sheet1[8,3] = "Est. Gross:"
            sheet1[8,4] = data_obj[:userInfo][:gross2]

            sheet1[9,0] = "No. of Deductions:"
            sheet1[9,1] = data_obj[:userInfo][:deductions]
            sheet1[9,3] = "No. of Deductions:"
            sheet1[9,4] = data_obj[:userInfo][:deductions2]

            sheet1[10,0] = "Est. Federal Taxes:"
            sheet1[10,1] = data_obj[:userInfo][:fed]
            sheet1[10,3] = "Est. Federal Taxes:"
            sheet1[10,4] = data_obj[:userInfo][:fed2]

            sheet1[11,0] = "Est. Local Taxes:"
            sheet1[11,1] = data_obj[:userInfo][:local]
            sheet1[11,3] = "Est. Local Taxes:"
            sheet1[11,4] = data_obj[:userInfo][:local2]

            sheet1[12,0] = "Est. Take Home:"
            sheet1[12,1] = data_obj[:userInfo][:net]
            sheet1[12,3] = "Est. Take Home:"
            sheet1[12,4] = data_obj[:userInfo][:net2]

            8.times do |x| sheet1.row(x + 5).set_format(0, label_format) end
            8.times do |x| sheet1.row(x + 5).set_format(1, standard_format) end
            8.times do |x| sheet1.row(x + 5).set_format(3, label_format) end
            8.times do |x| sheet1.row(x + 5).set_format(4, standard_format) end

            sheet1[14,0] = "Master Expense List"
            sheet1.row(14).default_format = header_format

            sheet1[15,0] = "No. Expenses:"
            sheet1[15,1] = data_obj[:userInfo][:numExpenses]
            
            sheet1[16,0] = "Expense Total:"
            sheet1[16,1] = data_obj[:userInfo][:totalExpenses]

            2.times do |x| sheet1.row(x + 15).set_format(0, label_format) end
            2.times do |x| sheet1.row(x + 15).set_format(1, standard_format) end

            sheet1[18,0] = "Name:"
            sheet1[18,1] = "Amount:"
            sheet1[18,2] = "Due Date:"
            sheet1.row(18).default_format = label_format

            for a in 0..data_obj[:expenses].length() -1 do
                expense = data_obj[:expenses][a]
                row_num = a + 19
                sheet1[row_num,0] = expense[:name]
                sheet1[row_num,1] = "$#{expense[:amount]}"
                sheet1[row_num,2] = expense[:date]
            end

            for a in 19..data_obj[:expenses].length() + 19 do
                sheet1.row(a).default_format = standard_format
            end
                
            (0...sheet1.column_count).each do |col_idx|
                column = sheet1.column(col_idx)
                column.width = column.each_with_index.map do |cell, row|
                    chars = cell.present? ? cell.to_s.strip.split('').count + 4 : 1
                    ratio = sheet1.row(row).format(col_idx).font.size / 12
                    (chars * ratio).round
                end.max
            end     
        end

        book.write "public/#{data_obj[:userInfo][:username]}-expense-info.xls"
    end

    def get_expenses_list(user_id)
        @expenses = Expense.where(user: user_id).all

        expenses_list = []
        for i in @expenses do
            expenses_list.append(clean_expense(i))
        end

        return expenses_list
    end

    def get_paychecks_list(user_id, income_src)
        @paychecks = Paycheck.where(user: user_id, income: income_src).all

        paychecks_list = []
        for i in @paychecks do
            id = i._id.to_s
            paychecks_list.append({date: i.date, id: id, income: income_src })
        end

        return paychecks_list
    end

    def get_debts_list(user_id)
        @debts = Debt.where(user: user_id).all

        debts_list = []
        for i in @debts do
            id = i._id.to_s
            debts_list.append({
                name: i.name, 
                type: i.type, 
                owed: i.owed, 
                limit: i.limit, 
                rate: i.rate, 
                payment: i.payment, 
                id: id
            })
        end

        return debts_list
    end

    def get_accounts_list(user_id)
        @accounts = Account.where(user: user_id).all

        accounts_list = []
        for i in @accounts do
            id = i._id.to_s
            expenses = i.expenses.map {|x| clean_expense(Expense.find_by(id: x))}

            accounts_list.append({
                name: i.name,
                start: i.start,
                total: i.total,
                end: i.end,
                expenses: expenses,
                id: id
                })
        end

        return accounts_list
    end

    def clean_expense(expense)
        id = expense._id.to_s
        return {
            name: expense.name, 
            amount: expense.amount, 
            date: expense.date, 
            account: expense.account_ids[0].to_s,
            id: id
        }
    end

    def save_paychecks(frequency, pay_date, user, income_src)
        # 5 years worth
        if frequency == "weekly"
            num_weeks = 260 
        elsif frequency == "bi-weekly"
            num_weeks = 130
        elsif frequency == "monthly"
            num_weeks = 60
        else
            num_weeks = 120
        end

        for a in 1..num_weeks do
            pay_date = get_next_paycheck(pay_date, frequency)
            @paycheck = Paycheck.new(
                date: pay_date,
                income: income_src,
                user_id: user,
            )
            if @paycheck.save
                puts "paycheck added"
            end
            if @paycheck.errors.any?
                @paycheck.errors.full_messages.each do |message|
                    puts message
                end
            end
        end
    end
end
