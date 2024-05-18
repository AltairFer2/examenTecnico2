const axios = require('axios');

const API_URL = 'https://jsonplaceholder.typicode.com/posts';

exports.getPosts = async (req, res) => {
    try {
        const response = await axios.get(API_URL);
        res.json(response.data);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

exports.getPostById = async (req, res) => {
    try {
        const response = await axios.get(`${API_URL}/${req.params.id}`);
        res.json(response.data);
    } catch (err) {
        console.error(err.message);
        res.status(404).send('Post no encontrado');
    }
};

exports.createPost = async (req, res) => {
    try {
        const { title, body, userId } = req.body;
        const post = {
            title,
            body,
            userId
        };
        const response = await axios.post(API_URL, post);
        res.json(response.data);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

exports.updatePost = async (req, res) => {
    try {
        const { title, body } = req.body;
        const response = await axios.put(`${API_URL}/${req.params.id}`, {
            title,
            body
        });
        res.json(response.data);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

// Eliminar un post
exports.deletePost = async (req, res) => {
    try {
        await axios.delete(`${API_URL}/${req.params.id}`);
        res.json({ msg: 'Post eliminado' });
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};
