// AUTHOR: @Hoàng Trọng Kiên. 17T1 BKĐN 
// 7/11/2020

/*
Get all subjects in database
Method: GET
Path: /subject
Query: NO
*/

/*
Get subjects by ID in database
Method: GET
Path: /subject
Query: {
    id_subject: ID of subject
}
*/

/*
Get all users in database
Method: GET
Path: /user
Query: NO
*/

/*
Get user by ID in database
Method: GET
Path: /user
Query: {
    id_user: ID of user
}
*/

/*
Get all subjects has in user by ID user
Method: GET
Path: /user/subject
Query: {
    id_user: ID of user
}
*/

/*
Add subjects to user
Method: POST
Path: /user/subject
Query: {
    id_user: ID of user
    id_subject: ID of subject need to be added
}
*/

/*
Get all completed subjects has in user by ID user
Method: GET
Path: /user/completed-subject
Query: {
    id_user: ID of user
}
*/

/*
Add completed subjects to user
Method: POST
Path: /user/completed-subject
Query: {
    id_user: ID of user
    id_subject: ID of subject need to be added
    point: user's point achieved in quiz
}
*/