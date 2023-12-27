/* eslint-disable */
import axios from './axios'

const url = '/attendance-manager'

const getStringQuery = (filter) => {
    const year = filter.year || new Date().getFullYear()
    let stringQuery = `?year=${year}`
    if (filter.month) {
        stringQuery += `&month=${filter.month}`
    }
    if (filter.dayOfMonth) {
        stringQuery += `&dayOfMonth=${filter.dayOfMonth}`
    }
    return stringQuery
}

class Api {
    getAllLog(filter) {
        return axios.get(`${url}/attendance-log/all${getStringQuery(filter)}`)
    }
    getLogsByUserId(userId, filter) {
        return axios.get(`${url}/attendance-log/user/${userId}${getStringQuery(filter)}`)
    }
    getLogById(id) {
        return axios.get(`${url}/attendance-log/${id}`)
    }
    getStatisticAll(filter) {
        return axios.get(`${url}/statistic/all${getStringQuery(filter)}`)
    }
    getStatisticDetailAll(filter) {
        return axios.get(`${url}/statistic/detail${getStringQuery(filter)}`)
    }
    getStatisticByUserId(userId, filter) {
        return axios.get(`${url}/statistic/user/${userId}${getStringQuery(filter)}`)
    }
    getStatisticManagementUnit(id, filter) {
        return axios.get(`${url}/statistic/${id}${getStringQuery(filter)}`)
    }

}

export default new Api()