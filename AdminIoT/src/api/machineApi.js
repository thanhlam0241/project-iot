/* eslint-disable */
import axios from './axios'

const url = '/attendance-machine'

class MachineApi {
    getAll() {
        return axios.get(url)
    }
    getById(id) {
        return axios.get(`${url}/${id}`)
    }
    create(data) {
        return axios.post(url, data)
    }
    update(id, data) {
        return axios.put(`${url}/${id}`, data)
    }
    delete(id) {
        return axios.delete(`${url}/${id}`)
    }
}

export default new MachineApi()