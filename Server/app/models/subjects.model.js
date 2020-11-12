const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const SubjectSchema = new Schema({
    _id: {type: Schema.Types.ObjectId, required: true},
    ten: {type: String, required: true},
    so_cau_hoi: {type: Number, required: true},
    diem_toi_da: {type: Number, required: true},
    thoi_gian: {type: Number, required: true},
    deadline: {type: String, required: true},
    data: {type: Array, required: true}
});


module.exports = mongoose.model("Subjects", SubjectSchema, "subjects");