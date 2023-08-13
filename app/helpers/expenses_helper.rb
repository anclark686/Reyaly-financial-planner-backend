module ExpensesHelper
  def get_basic_expenses(start_day, end_day, user_id)

    if end_day > start_day
      @expenses = Expense.where(
        user: user_id,
        :date => {:$gte => start_day, :$lte => end_day}
      ).all

    else
      @expenses1 = Expense.where(
        user: user_id,
        :date => {:$gte => start_day, :$lte => 31}
      ).all

      @expenses2 = Expense.where(
        user: user_id,
        :date => {:$gte => 1, :$lte => end_day}
      ).all

      return @expenses1 + @expenses2
    end
  end

  def get_actual_date(date_num)
    today = DateTime.now
    year = today.year
    month = today.mon
    day = today.mday

    if date_num < day
      if month != 12
        month += 1
      else
        month = 1
        year += 1
      end
    end

    return Date.new(year, month, date_num)
  end
end
