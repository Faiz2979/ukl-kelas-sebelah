const {PrismaClient} = require('@prisma/client');

const prisma = new PrismaClient();
const userModel = prisma.User;
const hash = require('md5');
const getUsers = async (request, response) => {
    try {
        const users = await userModel.findMany();
        response.status(200).json({
            status:true,
            message: "User list",
            data:users,
            }
        );
    } catch (error) {
        response.json({
            status:false,
            msg: error.message 
        });
    }
}

const addUser = async (req, res) => {
    const {  username, password } = req.body;
    const hashPassword = hash(password);
    let displayUser={
        username,
    }
    try {
        const user = await userModel.create({
            data: {
                username,
                password:hashPassword,
                createdAt: new Date(),
                updatedAt: new Date(),
            },
        });
        res.status(201).json(
            {
                status:"success",
                message: "User Berhasil Ditambahkan",
                data: displayUser,
            }
        );
    } catch (error) {
        res.status(500).json({ msg: error.message });
    }
}

module.exports = { getUsers, addUser };