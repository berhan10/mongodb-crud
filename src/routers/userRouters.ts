import express, { Application, Request, Response } from 'express'
import { User } from '../models/User'

const router = express.Router()

router.get('/', async (req: Request, res: Response) => {
    const result = await User.find({})
    return res.send(result)
})

router.get('/:id', async (req: Request, res: Response) => {
    const { id } = req.params
    const result = await User.findOne({ _id: id }) 
    return res.send(result)
})

router.post('/', async (req: Request, res: Response) => {
    await User.create(req.body).then((created) => {
        if (created != null) {
            return res.send({ status: true })
        }
    })
})

router.delete('/:userId', async (req: Request, res: Response) => {
    const { userId } = req.params
    await User.findByIdAndDelete(userId).then((deleted) => {
        if (deleted) {
            return res.send({ status: true })
        }
    })
})

export default router