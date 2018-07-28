
export default class SessionModel {
    constructor(name, id, createdAt, surveys) {
        this.name = name;
        this.id = id;
        this.createdAt = createdAt
        this.surveys = surveys;
    }
}
