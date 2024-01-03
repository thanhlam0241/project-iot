/* eslint-disable */
import axios from './axios'

const url = '/admin'

class Api {
    async getHumanStatistic() {
        return axios.get(`${url}/statistic/human`)
    }
    async getAttendanceStatistic(year) {
        if (!year) {
            year = new Date().getFullYear()
        }
        return axios.get(`${url}/statistic/attendance?year=${year}`)
    }
}

export default new Api()