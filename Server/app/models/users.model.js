const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const UserSchema = new Schema({
    _id: {type: Schema.Types.ObjectId, required: true},
    ten: {type: String, required: true},
    mssv: {type: String, required: true},
    lop: {type: String, required: true},
    password: {type: String, required: true},
    bai_trac_nghiem: {type: Array, required: true},
    da_hoan_thanh: {type: Array, required: true}
});


module.exports = mongoose.model("Users", UserSchema, "user");