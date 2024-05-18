const mongoose = require('mongoose');

const fileRecordSchema = new mongoose.Schema({
    fileName: {
        type: String,
        required: true
    },
    filePath: {
        type: String,
        required: true
    },
    fileType: {
        type: String,
        required: true
    },
    fileSize: {
        type: Number,
        required: true
    },
    uploadedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    }
}, { timestamps: true }); // `timestamps` añade automáticamente campos para `createdAt` y `updatedAt`.

module.exports = mongoose.model('FileRecord', fileRecordSchema);
