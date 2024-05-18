const Post = require('../models/Post');

// Obtener todas las publicaciones
exports.getPosts = async (req, res) => {
    try {
        const posts = await Post.find();
        res.json(posts);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

// Obtener una publicación por ID
exports.getPostById = async (req, res) => {
    try {
        const post = await Post.findById(req.params.id);
        if (!post) {
            return res.status(404).send('Post no encontrado');
        }
        res.json(post);
    } catch (err) {
        console.error(err.message);
        res.status(404).send('Post no encontrado');
    }
};

// Crear una nueva publicación
exports.createPost = async (req, res) => {
    try {
        const { title, body, userId } = req.body;
        const newPost = new Post({
            title,
            body,
            userId,
        });

        const post = await newPost.save();
        res.status(201).json(post);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de servidor');
    }
};

// Actualizar una publicación
exports.updatePost = async (req, res) => {
    try {
        const { title, body } = req.body;
        const post = await Post.findByIdAndUpdate(
            req.params.id,
            { title, body },
            { new: true }
        );
        res.json(post);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

// Eliminar una publicación
exports.deletePost = async (req, res) => {
    try {
        await Post.findByIdAndDelete(req.params.id);
        res.json({ msg: 'Post eliminado' });
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};
