const FileRecord = require('../models/FileRecord');
const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/');
    },
    filename: function (req, file, cb) {
        cb(null, new Date().toISOString().replace(/:/g, '-') + '-' + file.originalname);
    }
});

const upload = multer({ storage: storage });

exports.uploadFile = upload.single('file');

exports.saveFileRecord = async (req, res) => {
    if (!req.file) {
        return res.status(400).send('No se han actualizado archivos.');
    }

    try {
        const newFile = new FileRecord({
            fileName: req.file.filename,
            filePath: req.file.path,
            fileType: req.file.mimetype,
            fileSize: req.file.size,
            uploadedBy: req.user._id
        });

        await newFile.save();
        res.json(newFile);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

exports.getFiles = async (req, res) => {
    try {
        const files = await FileRecord.find();
        res.json(files);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};
