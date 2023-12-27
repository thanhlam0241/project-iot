/* eslint-disable  */

import { useState, useEffect, useMemo } from 'react';
import Paper from '@mui/material/Paper';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';
// import Button from '@mui/material/Button';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TablePagination from '@mui/material/TablePagination';
import TableRow from '@mui/material/TableRow';

import TableToolbar from './toolbar-timesheet.jsx';
import attendanceManagerApi from 'src/api/attendanceManagerApi.js';
import { Backdrop } from 'src/components/backdrop';
import { set } from 'lodash';

const columns = [
    { id: 'code', label: 'Mã nhân viên', minWidth: 100 },
    { id: 'name', label: 'Tên nhân viên', minWidth: 100 },
    { id: 'managementUnit', label: 'Máy chấm công', minWidth: 100 },
    { id: 'machineName', label: 'Phòng ban', minWidth: 100 },
    { id: 'date', label: 'Ngày', minWidth: 100 },
    { id: 'time', label: 'Thời gian', minWidth: 100 }
];

function createData(code, name, managementUnit, machineName, date, time) {
    return { code, name, managementUnit, machineName, date, time };
}

export default function StickyHeadTable() {
    const [page, setPage] = useState(0);
    const [rowsPerPage, setRowsPerPage] = useState(10);

    const [filterName, setFilterName] = useState('');
    const [openFilter, setOpenFilter] = useState(false);

    const [date, setDate] = useState(new Date());

    const [data, setData] = useState([])
    const [loading, setLoading] = useState(false);

    const fetchData = async () => {
        try {
            setLoading(true)
            console.log(date)
            const filter = {
                year: date.getFullYear(),
                month: date.getMonth() + 1,
                dayOfMonth: date.getDate()
            }
            console.log(filter)
            const res = await attendanceManagerApi.getAllLog(filter)
            if (res.status === 200) {
                setData(res.data.map((item) => {
                    return createData(
                        item.user.code,
                        item.user.fullName,
                        item.attendanceMachine.name,
                        item.attendanceMachine.name,
                        `${item.dayOfMonth}/${item.month}/${item.year}`,
                        `${item.hour}:${item.minute}`
                    )
                }))
            }
            console.log(res)
        } catch (error) {
            console.log(error)
        } finally {
            setLoading(false)
        }
    }

    const dataFilter = useMemo(() => {
        if (!filterName) return data
        return data.filter((item) => {
            return item.name.toLowerCase().includes(filterName.toLowerCase())
        })
    }, [data, filterName])

    useEffect(() => {
        fetchData()
    }, [date])

    const handleOpenFilter = () => {
        console.log("Open filter")
        setOpenFilter(true);
    };

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
            <Stack direction="row" alignItems="center" justifyContent="space-between" mb={1}>
                <Typography variant="h4">Danh sách bản ghi chấm công</Typography>
            </Stack>
            <TableToolbar
                date={date}
                filterName={filterName}
                onFilterName={setFilterName}
                onChaneDate={setDate}
                onOpenFilter={handleOpenFilter}
            />
            <TableContainer sx={{ height: 440 }} >
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
