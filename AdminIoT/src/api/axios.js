/* eslint-disable */

import axios from 'axios'
import SERVER_URL from 'src/utils/resource'
const baseUrl = `${SERVER_URL}/api/v1`

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