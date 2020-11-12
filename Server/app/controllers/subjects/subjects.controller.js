const Subject = require('../../models/subjects.model');

module.exports = {
    getSubject: async (req, res, next) => {
        let id = req.query.id_subject
        if (id == undefined) {
            // because have no id subject. Func return all subjects.
            let subjects = await Subject.find()
            if (subjects == null) {
                res.writeHead(404, { "Content-Type": "application/json" })
                let error = { "error": "no subject exists!" }
                res.end(JSON.stringify(error))
                return
            }
            let jsonResponse = JSON.stringify(subjects)

            // res.send(jsonResponse)
            res.writeHead(200, { "Content-Type": "application/json" })
            res.end(jsonResponse)
        }
        // check valid id user
        else if (String(id).length != 24) {
            res.writeHead(400, { "Content-Type": "application/json" })
            let error = { "error": "id subject wrong!" }
            res.end(JSON.stringify(error))
            return
        }
        else {
            let subject = await Subject.findById(id)
            if (subject == null) {
                res.writeHead(404, { "Content-Type": "application/json" })
                let error = { "error": "no subject exists!" }
                res.end(JSON.stringify(error))
                return
            }

            let jsonResponse = JSON.stringify(subject)
            res.writeHead(200, { "Content-Type": "application/json" })
            res.end(jsonResponse)
        }


    }
}