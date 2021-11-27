import { Model, Types, Document } from 'mongoose'
const { mongoose, model, Schema } = require('mongoose')

const UserSchema = new Schema(
    {
        name: { type: String, required: true },
    },
    { collection: 'User', timestamps: true }
)

const User: Model<Document> = model('User', UserSchema)

export { User }
