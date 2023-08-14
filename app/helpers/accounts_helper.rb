module AccountsHelper
    def clean_other_accounts(account, expenses)
        for i in expenses do
            other_accounts = i.account_ids

            for num in other_accounts.length.downto(0) do
                if other_accounts[num] != account._id 
                    if other_accounts[num]
                        remove_expense(other_accounts[num], i)
                        i.pull(account_ids: other_accounts[num])
                    end
                end
            end
        end
    end

    def remove_expense(account, expense)
        begin
            other_acct = Account.find_by(id: account)
            other_acct.pull(expense_ids: expense._id)
        rescue Mongoid::Errors::DocumentNotFound => err
            puts err
        end
        
    end
end
