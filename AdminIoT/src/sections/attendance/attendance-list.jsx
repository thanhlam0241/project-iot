/* eslint-disable  */

import * as React from 'react';
import Paper from '@mui/material/Paper';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TablePagination from '@mui/material/TablePagination';
import TableRow from '@mui/material/TableRow';

import AttendanceToolbar from './toolbar-attendance.jsx';
import attendanceManagerApi from 'src/api/attendanceManagerApi.js';
import { Backdrop } from 'src/components/backdrop';

const columns = [
    { id: 'stt', label: 'STT', minWidth: 100 },
    { id: 'code', label: 'Mã nhân viên', minWidth: 100 },
    { id: 'name', label: 'Tên nhân viên', minWidth: 100 },
    { id: 'managementUnit', label: 'Phòng ban', minWidth: 100 },
    { id: 'numberOfShifts', label: 'Số ca làm việc', minWidth: 100 },
    { id: 'numberMorningShift', label: 'Số ca sáng', minWidth: 100 },
    { id: 'numberAfternoonShift', label: 'Số ca chiều', minWidth: 100 },
    // { id: 'numberOfLateShifts', label: 'Số ca đi muộn', minWidth: 100 },
    { id: 'numberOfLateHours', label: 'Số giờ đi muộn', minWidth: 100 },
    // { id: 'numberOfAbsentShifts', label: 'Số ca nghỉ', minWidth: 100 },
    // {
    //     id: 'density',
    //     label: 'Density',
    //     minWidth: 170,
    //     align: 'right',
    //     format: (value) => value.toFixed(2),
    // },
];

function createData(stt, code, name, managementUnit, numberOfShifts, numberMorningShift, numberAfternoonShift, numberOfLateShifts, numberOfLateHours, numberOfAbsentShifts) {
    return { stt, code, name, managementUnit, numberOfShifts, numberMorningShift, numberAfternoonShift, numberOfLateShifts, numberOfLateHours, numberOfAbsentShifts };
}

const rows = [];

const listFirstName = ['Nguyễn', 'Trần', 'Lê', 'Phạm', 'Hoàng', 'Huỳnh', 'Phan']
const listMiddleName = ['Thị', 'Văn', 'Đức', 'Hoa', 'Thế', 'Hồng', 'Thành']
const listLastName = ['Hoa', 'Đức', 'Hùng', 'Hải', 'Hà', 'Hồng', 'Thành']

const listDepartment = ['Phòng kinh doanh', 'Phòng kế toán', 'Phòng nhân sự', 'Phòng kỹ thuật', 'Phòng hành chính', 'Phòng phát triển', 'Phòng sản xuất']

const randomInRangeInt = (min, max) => {
    return Math.floor(Math.random() * (max - min + 1) + min);
}

const randomName = () => {
    return `${listFirstName[Math.floor(Math.random() * listFirstName.length)]} ${listMiddleName[Math.floor(Math.random() * listMiddleName.length)]} ${listLastName[Math.floor(Math.random() * listLastName.length)]}`
}

// Tạo thêm 30 dữ liệu
for (let i = 1; i <= 50; i++) {
    let numberOfShifts = randomInRangeInt(40, 50)
    let numberMorningShift = randomInRangeInt(20, 30)
    let numberAfternoonShift = numberOfShifts - numberMorningShift
    rows.push(
        createData(
            i,
            `NV0000${i}`,
            randomName(),
            listDepartment[Math.floor(Math.random() * listDepartment.length)],
            numberOfShifts,
            numberMorningShift,
            numberAfternoonShift,
            randomInRangeInt(0, 10),
            randomInRangeInt(0, 10),
            randomInRangeInt(0, 10),
        )
    )
}

export default function StickyHeadTable() {
    const [page, setPage] = React.useState(0);
    const [rowsPerPage, setRowsPerPage] = React.useState(10);

    const [year, setYear] = React.useState(new Date().getFullYear())
    const [month, setMonth] = React.useState(new Date().getMonth() + 1)

    const [filterName, setFilterName] = React.useState('');

    const [data, setData] = React.useState([])
    const [loading, setLoading] = React.useState(false);

    const dataFilter = React.useMemo(() => {
        if (!filterName) return data
        return data.filter((item) => {
            return item.name.toLowerCase().includes(filterName.toLowerCase())
        })
    }, [data, filterName])


    const fetchData = async () => {
        try {
            setLoading(true)
            console.log(year, month)
            const filter = {
                year: year,
                month: month
            }
            const response = await attendanceManagerApi.getStatisticDetailAll(filter)
            if (response.status === 200) {
                setData(response.data.map((item, index) => {
                    return createData(
                        index + 1,
                        item.code,
                        item.name,
                        item.managementUnitName,
                        item.statistic.numberOfShifts,
                        item.numberOfMorning,
                        item.numberOfAfternoon,
                        item.statistic.numberOfLateShifts,
                        parseFloat(item.statistic.numberMinutesLate / 60).toFixed(2),
                        item.statistic.numberOfAbnormalShifts,
                    )
                }))
            }
            console.log(response)
        } catch (error) {
            console.log(error)
        } finally {
            setLoading(false)
        }
    }

    React.useEffect(() => {
        console.log('Fetch data')
        fetchData()
    }, [year, month])

    const handleChangePage = (event, newPage) => {
        setPage(newPage);
    };

    const handleChangeRowsPerPage = (event) => {
        setRowsPerPage(+event.target.value);
        setPage(0);
    };

    return (
        <Paper sx={{ width: '100%', overflow: 'auto' }}>
            <Backdrop open={loading} />
            <Stack direction="column" alignItems="stretch" justifyContent="space-between"  >
                <Typography variant="h4">Danh sách chấm công</Typography>
                <AttendanceToolbar
                    changeMonth={setMonth}
                    changeYear={setYear}
                    onFilterName={setFilterName}
                    defaultValueMonth={month.toString()}
                    defaultValueYear={year.toString()}
                />
            </Stack>
            <TableContainer sx={{ height: 450, border: '1px solid #ccc', borderRadius: '4px 4px 0 0 ' }} >
                <Table stickyHeader aria-label="sticky table">
                    <TableHead>
                        <TableRow>
                            {columns.map((column) => (
                                <TableCell
                                    key={column.id}
                                    align={column.align}
                                    style={{ minWidth: column.minWidth }}
                                >
                                    {column.label}
                                </TableCell>
                            ))}
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {dataFilter.length > 0 && dataFilter
                            .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                            .map((row) => {
                                return (
                                    <TableRow hover role="checkbox" tabIndex={-1} key={row.code}>
                                        {columns.map((column) => {
                                            const value = row[column.id];
                                            return (
                                                <TableCell key={column.id} align={column.align}>
                                                    {column.format && typeof value === 'number'
                                                        ? column.format(value)
                                                        : value}
                                                </TableCell>
                                            );
                                        })}
                                    </TableRow>
                                );
                            })}
                        {
                            data.length === 0 && !loading &&
                            <TableRow>
                                <TableCell align="center" colSpan={10} sx={{ py: 16 }}>
                                    <Paper
                                        sx={{
                                            textAlign: 'center',
                                        }}
                                    >
                                        <Typography variant="body2">
                                            Không tìm thấy kết quả
                                        </Typography>
                                    </Paper>
                                </TableCell>
                            </TableRow>
                        }
                    </TableBody>
                </Table>
            </TableContainer>
            <TablePagination
                rowsPerPageOptions={[10, 50, 100]}
                component="div"
                count={dataFilter.length}
                rowsPerPage={rowsPerPage}
                page={page}
                onPageChange={handleChangePage}
                onRowsPerPageChange={handleChangeRowsPerPage}
            />
        </Paper>
    );
}
