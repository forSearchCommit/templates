export class Access {
    public AccessRight: Array<string>;
    public Currency: Array<string>;

    private getAccessList(): Array<string> {
        var stored = localStorage.getItem('promotionUserAccess');
        if (stored != null) {
            return JSON.parse(stored);
        }
        else {
            return [];
        }
    }

    private getCurrency(): Array<string> {
        var stored = localStorage.getItem("promotionUserCurrency");
        if (stored != null) {
            return JSON.parse(stored);
        }
        else {
            return [];
        }
    }

    constructor() {
        this.AccessRight = this.getAccessList();
        this.Currency = this.getCurrency();
    }

    public IsAccessible(access): Boolean {
        var allowed = false;
        if (this.AccessRight != null && this.AccessRight.length > 0 && this.AccessRight.indexOf(access) >= 0) {
            allowed = true
        }
        return allowed;
    }

    public IsGroupAccessible(accesslist: Array<string>): Boolean {
        var accessRight = this.AccessRight;
        var allowed = accesslist.some(function (value) {
            return accessRight != null && accessRight.length > 0 && accessRight.indexOf(value) >= 0;
        });
        return allowed;
    }

    public hasCurrency(currency): Boolean {
        var currencyList = this.Currency;
        var allow = false;
        if (currencyList != null && currencyList.length > 0 && currencyList.indexOf(currency) >= 0) {
            allow = true;
        }
        return allow
    }
}

export const AccessList = {
    View_User_List: '001_01_01',
    Add_User: '001_02_01',
    Edit_User: '001_03_01',
    Delete_User: '001_04_01',
    Reset_User_Password: '001_05_01',
    View_User_Log: '001_06_01',

    View_Bank_Summary_List: '002_01_01',
    Add_Bank_Account: '002_02_01',
    Edit_Bank_Account: '002_03_01',
    View_Bank_Account:'002_03_03',
    Pause_Bot: '002_03_02',//ask
    Edit_Bank_VBotStatus:'002_03_04',
    Run_Account: '002_04_01',//bot trigger
    View_Bank_Account_Log: '002_05_01',
    View_Bank_Detail: '002_06_01',
    Import_Bank_Account: '002_07_01',
    View_Bank_LoginDetail : '002_08_01',
    Edit_Bank_LoginDetail : '002_09_01',
    Edit_Bank_ResumeVBot : '002_10_01',
    Edit_Bank_PauseVBot : '002_10_02',

    View_Transaction_History: '003_01_01',
    Edit_Purpose: '003_02_01',
    DP_Claim_Approval: '003_03_01',
    Reverse_DP_Transaction: '003_03_02',
    WD_Claim_Approval: '003_03_03',
    Reverse_WD_Transaction: '003_03_04',
    View_Transaction_Log: '003_04_01',
    Delete_Transaction: '003_05_01',
    Import_Transaction_History: '003_06_01',
    Export_Transaction_History: '003_07_01',

    View_User_Group: '004_01_01',
    Add_User_Group: '004_02_01',
    Edit_User_Group: '004_03_01',
    Delete_User_Group: '004_04_01',

    View_Workers: '005_01_01',
    Add_Workers: '005_02_01',
    Edit_Workers: '005_03_01',
    Set_On_Off_Workers: '005_04_01',
    Delete_Workers: '005_05_01',
    View_Workers_Log: '005_06_01',
    Reset_Bank_Count: '005_07_01',
    Worker_IP_Whitelist : '005_08_01',
    Update_Worker_IP_Whitelist : '005_08_02',

    Authenticator:"007_00_00"
}