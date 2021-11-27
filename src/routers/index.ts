import express, { Application, Request, Response } from 'express'
import users from './userRouters'

const router = express.Router()
router.use('/users/', users)

export { router }
