export class SignInData{
    private userId: string;
    private password: string;

    constructor(userId: string, password: string){
        this.userId = userId;
        this.password = password;
    }

    getUserId(): string{
        return this.userId;
    }

    getPassword(): string{
        return this.password;
    }
}