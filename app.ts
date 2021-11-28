import express, { Application, Request, Response } from 'express'
import Mongoose, { ConnectOptions } from 'mongoose'
import { router } from './src/routers'

const app: Application = express()

app.use(express.json())

app.use('/api/', router)


Mongoose.connect(`mongodb://rydell-router-01:27017/database1`, {
    useUnifiedTopology: true,
    useNewUrlParser: true,
} as ConnectOptions)
    .then(() => {
        app.listen(3000, () => {
            console.log('Server ve database aktif. ', 3000)
        })
    })
    .catch((hata: any) => {
        console.log(`${hata}`)
    })
