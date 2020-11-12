const User = require('../../models/users.model');
const Subject = require('../../models/subjects.model');


module.exports = {
    getUsers: async (req, res, next) => {
        let id = req.query.id_user
        if (id == undefined) {
            // because have no id user. Func return all users.
            let users = await User.find()

            // check null id user
            if (users == null) {
                res.writeHead(404, { "Content-Type": "application/json" })
                let error = { "error": "no user exists!" }
                res.end(JSON.stringify(error))
                return
            }
            let jsonResponse = JSON.stringify(users)

            res.writeHead(200, { "Content-Type": "application/json" })
            res.end(jsonResponse)
        }
        // check valid id user
        else if (String(id).length != 24) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = { "error": "id user wrong!" }
            res.end(JSON.stringify(error))
            return
        }
        else {
            let user = await User.findById(id)
            if (user == null) {
                res.writeHead(404, { "Content-Type": "application/json" })
                let error = { "error": "no user exists!" }
                res.end(JSON.stringify(error))
                return
            }

            // True
            res.writeHead(200, { "Content-Type": "application/json" })
            let response = {
                "success": true,
                "response": user
            }
            res.end(JSON.stringify(response))
            return
        }

    },
    getCompletedSubject: async (req, res, next) => {
        let idUser = req.query.id_user

        if (idUser == null) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "error": "field id_user is required!"
            }
            res.end(JSON.stringify(error))
            return
        }
        // check valid id user
        if (String(idUser).length != 24) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = { "error": "id user wrong!" }
            res.end(JSON.stringify(error))
            return
        }

        let user = await User.findById(idUser)
        if (user == null) {
            res.writeHead(404, { "Content-Type": "application/json" })
            let error = { "error": "id user no exists!" }
            res.end(JSON.stringify(error))
            return
        }

        let response = user.da_hoan_thanh
        let result = { "array_completed_subject": response }
        let jsonResponse = JSON.stringify(result)
        res.writeHead(200, { "Content-Type": "application/json" })
        res.end(jsonResponse)
    },
    postCompletedSubject: async (req, res, next) => {
        // Swift post data with body. So can't use query below
        // let idUser = req.query.id_user
        // let idCompletedSubject = req.query.id_subject
        // let point = req.query.point

        let idUser = req.body.id_user
        let idCompletedSubject = req.body.id_subject
        let point = req.body.point
        console.log("id_user:" + idUser);
        console.log("id_completedSubject:" + idCompletedSubject);
        console.log("point:" + point);
        // check valid point
        if (point == null) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "field point is required!"
            }
            res.end(JSON.stringify(error))
            return
        }
        if (point < 0 || point > 10) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "field point is wrong!"
            }
            res.end(JSON.stringify(error))
            return
        }

        // check valid id user
        if (String(idUser).length != 24) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "id user wrong!"
            }
            res.end(JSON.stringify(error))
            return
        }

        let user = await User.findById(idUser)
        if (user == null) {
            res.writeHead(404, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "id user no exists!"
            }
            res.end(JSON.stringify(error))
            return
        }

        // check valid id subject
        if (String(idCompletedSubject).length != 24) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "id subject wrong!"
            }
            res.end(JSON.stringify(error))
            return
        }

        let subject = await Subject.findById(idCompletedSubject)
        if (subject == null) {
            res.writeHead(404, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "id subject no exists!"
            }
            res.end(JSON.stringify(error))
            return
        }

        let name = subject.ten
        // check exist id subject in user
        let completedSubject = user.da_hoan_thanh
        let ids = completedSubject.map((item) => {
            return item.id
        })

        if (ids.indexOf(idCompletedSubject) != -1) {
            // id subject exist in user
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "id subject exist in user!"
            }
            res.end(JSON.stringify(error))
        }
        else {
            let maxPoint = subject.diem_toi_da

            // add id subject to user
            let param = {
                "id": idCompletedSubject,
                "ten": name,
                "diem": point,
                "diem_toi_da": maxPoint,
                "ngay_hoan_thanh": getDateTime()
            }
            User.updateOne(
                {
                    "_id": idUser
                },
                {
                    "$push": {
                        "da_hoan_thanh": param
                    }
                }, function (err, res) {
                    if (err) throw err;
                }
            )

            res.writeHead(200, { "Content-Type": "application/json" })
            let response = {
                "success": true,
                "response": ""
            }
            res.end(JSON.stringify(response))
        }
    },
    getSubjectByUser: async (req, res, next) => {
        let idUser = req.query.id_user

        if (idUser == null) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "field id_user is required!"
            }
            res.end(JSON.stringify(error))
            return
        }
        // check valid id user
        if (String(idUser).length != 24) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "id user wrong!"
            }
            res.end(JSON.stringify(error))
            return
        }

        let user = await User.findById(idUser)
        if (user == null) {
            res.writeHead(404, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "id user no exists!"
            }
            res.end(JSON.stringify(error))
            return
        }

        let id_subjects = user.bai_trac_nghiem.map((item) => {
            return item.id
        })
        user.da_hoan_thanh.map((item) => {
            let index = id_subjects.indexOf(item.id)
            if (index > -1) {
                id_subjects.splice(index, 1);
            }
            // return item.id
        })
        let response = []
        for (let id of id_subjects) {
            let subject = await Subject.findById(id)
            response.push(subject)
        }
        let result = { "array_subject": response }
        let jsonResponse = JSON.stringify(result)
        res.writeHead(200, { "Content-Type": "application/json" })
        res.end(jsonResponse)
    },
    postSubjectByUser: async (req, res, next) => {
        let idUser = req.query.id_user
        let idSubject = req.query.id_subject

        // check valid id user
        if (String(idUser).length != 24) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = { "error": "id user wrong!" }
            res.end(JSON.stringify(error))
            return
        }

        let user = await User.findById(idUser)
        if (user == null) {
            res.writeHead(404, { "Content-Type": "application/json" })
            let error = { "error": "id user no exists!" }
            res.end(JSON.stringify(error))
            return
        }

        // check valid id subject
        if (String(idSubject).length != 24) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = { "error": "id subject wrong!" }
            res.end(JSON.stringify(error))
            return
        }

        let subject = await Subject.findById(idSubject)
        if (subject == null) {
            res.writeHead(404, { "Content-Type": "application/json" })
            let error = { "error": "id subject no exists!" }
            res.end(JSON.stringify(error))
            return
        }

        // check exist id subject in user
        let quiz = user.bai_trac_nghiem
        let ids = quiz.map((item) => {
            return item.id
        })

        if (ids.indexOf(idSubject) != -1) {
            // id subject exist in user
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "error": "id subject exist in user!"
            }
            res.end(JSON.stringify(error))
        }
        else {
            // add id subject to user
            let param = {
                "id": idSubject,
            }
            User.updateOne(
                {
                    "_id": idUser
                },
                {
                    "$push": {
                        "bai_trac_nghiem": param
                    }
                }, function (err, res) {
                    if (err) throw err;
                }
            )

            res.writeHead(200, { "Content-Type": "application/json" })
            let response = { "success": true }
            res.end(JSON.stringify(response))
        }
    },
    checkLogin: async (req, res, next) => {
        // Swift send data in body
        // let mssv = req.query.mssv
        // let password = req.query.password
        console.log(req.body);
        let mssv = req.body.mssv
        let password = req.body.password
        console.log("mssv:" + mssv);
        console.log("password:" + password);
        if (mssv == null) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "field mssv is required!"
            }
            res.end(JSON.stringify(error))
            return
        }
        if (password == null) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "field password is required!"
            }
            res.end(JSON.stringify(error))
            return
        }
        if (String(mssv).length != 9) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "length mssv wrong!"
            }
            res.end(JSON.stringify(error))
            return
        }
        let users = await User.find()
        console.log(users);
        let user = users.filter((item) => {
            return item.mssv == mssv
        })

        console.log(user);
        if (user[0] == undefined) {
            res.writeHead(404, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "mssv incorrect!"
            }
            res.end(JSON.stringify(error))
            return
        }

        if (user[0].password != password) {
            res.writeHead(404, { "Content-Type": "application/json" })
            let error = {
                "success": false,
                "response": "password incorrect!"
            }
            res.end(JSON.stringify(error))
            return
        }

        // True
        res.writeHead(200, { "Content-Type": "application/json" })
        let error = {
            "success": true,
            "response": user[0]
        }
        res.end(JSON.stringify(error))
        return
    }
}

function getDateTime() {
    let date = new Date()
    return date.toLocaleTimeString() + " " + date.toLocaleDateString()
}