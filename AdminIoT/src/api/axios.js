/* eslint-disable */

import axios from 'axios'

// const baseUrl = 'http://localhost:8080/api/v1'
const baseUrl = 'https://server-iot-tggk.onrender.com//api/v1'

const instance = axios.create({
    baseURL: baseUrl,
    timeout: 30000,
    headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
    }
})

instance.interceptors.request.use(
    (config) => {
        return config
    },
    (error) => {
        return Promise.reject(error)
    }
)

instance.interceptors.response.use(
    (response) => {
        return response
    },
    (error) => {
        return Promise.reject(error)
    }
)

export default instance