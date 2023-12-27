/* eslint-disable */

const listFirstName = ['Nguyễn', 'Trần', 'Lê', 'Phạm', 'Hoàng', 'Huỳnh', 'Phan']
const listMiddleName = ['Thị', 'Văn', 'Đức', 'Hoa', 'Thế', 'Hồng', 'Thành']
const listLastName = ['Hoa', 'Đức', 'Hùng', 'Hải', 'Hà', 'Hồng', 'Thành']

const randomInRangeInt = (min, max) => {
    return Math.floor(Math.random() * (max - min + 1) + min);
}

const randomName = () => {
    return `${listFirstName[Math.floor(Math.random() * listFirstName.length)]} ${listMiddleName[Math.floor(Math.random() * listMiddleName.length)]} ${listLastName[Math.floor(Math.random() * listLastName.length)]}`
}

const createCodeFormat8 = (code) => {
    let codeFormat = code
    for (let i = 0; i < 8 - code.toString().length; i++) {
        codeFormat = `0${codeFormat}`
    }
    return 'MA' + codeFormat
}

const randomPhoneNumber = () => {
    let phoneNumber = '0'
    for (let i = 0; i < 9; i++) {
        phoneNumber += randomInRangeInt(0, 9)
    }
    return phoneNumber
}

const ramdomAddress = () => {
    const listAddress = ['Hà Nội', 'Hồ Chí Minh', 'Đà Nẵng', 'Hải Phòng', 'Quảng Ninh', 'Hải Dương', 'Hưng Yên', 'Nam Định', 'Ninh Bình',
        'Thanh Hóa', 'Nghệ An', 'Hà Tĩnh', 'Quảng Bình', 'Quảng Trị', 'Thừa Thiên Huế', 'Quảng Nam', 'Quảng Ngãi', 'Bình Định', 'Phú Yên',
        'Khánh Hòa', 'Ninh Thuận', 'Bình Thuận', 'Kon Tum', 'Gia Lai', 'Đắk Lắk', 'Đắk Nông', 'Lâm Đồng', 'Bình Phước', 'Bình Dương', 'Đồng Nai',
        'Tây Ninh', 'Bà Rịa - Vũng Tàu', 'Long An', 'Đồng Tháp', 'Tiền Giang', 'An Giang', 'Bến Tre', 'Vĩnh Long', 'Trà Vinh', 'Hậu Giang', 'Kiên Giang',
        'Sóc Trăng', 'Bạc Liêu', 'Cà Mau']
    return listAddress[Math.floor(Math.random() * listAddress.length)]
}

const randomIdentityCard = () => {
    let identityCard = ''
    for (let i = 0; i < 9; i++) {
        identityCard += randomInRangeInt(0, 9)
    }
    return identityCard
}

const listDepartments = [
    '657bbe0949a0e8000e2ee038', '657bbe8449a0e8000e2ee039', '657bbe8e49a0e8000e2ee03a', '657ebceba15e4b3554022b12', '658165fdd401ca21fdf63928',
    '65816609d401ca21fdf63929', '65816614d401ca21fdf6392a', '65816627d401ca21fdf6392b', '6581664ed401ca21fdf6392c', '6581666fd401ca21fdf6392d',
    '65816695d401ca21fdf6392e', '658166a0d401ca21fdf6392f', '658166afd401ca21fdf63930'
]

const listData = []

for (let i = 0; i < 100; i++) {
    listData.push({
        code: createCodeFormat8(i + 1),
        fullName: randomName(),
        managementUnitId: listDepartments[Math.floor(Math.random() * listDepartments.length)],
        identityCard: randomIdentityCard(),
        phone: randomPhoneNumber(),
        address: ramdomAddress(),
        username: `user${i + 1}`,
        password: '123456',
        role: 'EMPLOYEE',
        email: `user${i + 1}@gmail.com`,
        active: true,
    })
}

const baseUrl = 'http://localhost:8080/api/v1/user'

const generateTimeBetweenHour = (min, max, day, month, year) => {
    // format dd-MM-yyyy HH:mm:ss.SSS Z
    const hourRandom = randomInRangeInt(min, max)
    const minuteRandom = randomInRangeInt(0, 59)
    const secondRandom = randomInRangeInt(0, 59)

    const hour = hourRandom < 10 ? `0${hourRandom}` : `${hourRandom}`
    const minute = minuteRandom < 10 ? `0${minuteRandom}` : `${minuteRandom}`
    const second = secondRandom < 10 ? `0${secondRandom}` : `${secondRandom}`
    const dateFormat = day < 10 ? `0${day}` : `${day}`
    const monthFormat = month < 10 ? `0${month}` : `${month}`
    const yearFormat = `${year}`

    return `${dateFormat}-${monthFormat}-${yearFormat} ${hour}:${minute}:${second}.000 +0700`
}

function sendHttpPostRequest(url, data) {
    return new Promise((resolve, reject) => {
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
            },
            body: JSON.stringify(data)
        })
            .then(() => {
                console.log('ok')
            })
            .catch(error => {
                reject(error);
            });
    });
}

export default function sendPostRequest(users, listMachines) {
    const promises = [];

    for (let i = 0; i < listMachines.length; i++) {
        const manager = {
            fullName: randomName(),
            identityCard: randomIdentityCard(),
            phone: randomPhoneNumber(),
            address: ramdomAddress(),
            username: `manager${i + 1}`,
            password: '123456',
            role: 'MANAGER',
            email: `manager${i + 1}@gmail.com`,
            active: true,
            managementUnitId: listMachines[i].managementUnit.id,
            gender: ['MALE', 'FEMALE'][Math.floor(Math.random() * 2)],
            code: createCodeFormat8(i + 1),
        }
        promises.push(sendHttpPostRequest(baseUrl, manager))
    }

    Promise.all(promises).then((values) => {
        console.log(values);
    }
    ).catch((err) => {
        console.log(err);
    });
}
