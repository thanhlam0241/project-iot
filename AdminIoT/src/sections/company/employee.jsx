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

import Iconify from 'src/components/iconify';

import EmployeeForm from './employee-form';

const columns = [
    { id: 'stt', label: 'STT', minWidth: 100 },
    { id: 'code', label: 'Mã NV', minWidth: 100 },
    { id: 'name', label: 'Tên NV', minWidth: 100 },
    { id: 'managementUnit', label: 'Phòng ban', minWidth: 100 },
    { id: 'phone', label: 'Số điện thoại', minWidth: 100 },
    { id: 'address', label: 'Địa chỉ', minWidth: 100 },
    // {
    //     id: 'density',
    //     label: 'Density',
    //     minWidth: 170,
    //     align: 'right',
    //     format: (value) => value.toFixed(2),
    // },
];

function createData(stt, code, name, managementUnit, phone, address) {
    return { stt, code, name, managementUnit, phone, address };
}

const rows = [];

const listFirstName = ['Nguyễn', 'Trần', 'Lê', 'Phạm', 'Hoàng', 'Huỳnh', 'Phan']
const listMiddleName = ['Thị', 'Văn', 'Đức', 'Hoa', 'Thế', 'Hồng', 'Thành']
const listLastName = ['Hoa', 'Đức', 'Hùng', 'Hải', 'Hà', 'Hồng', 'Thành']

const listDepartment = ['Phòng kinh doanh', 'Phòng kế toán', 'Phòng nhân sự', 'Phòng kỹ thuật', 'Phòng hành chính', 'Phòng phát triển', 'Phòng sản xuất']

const randomPhoneNumber = () => {
    let phone = '0'
    for (let i = 0; i < 9; i++) {
        phone += Math.floor(Math.random() * 10)
    }
    return phone
}

// Tạo thêm 30 dữ liệu
for (let i = 1; i <= 100; i++) {
    rows.push(
        createData(
            i,
            `NV0000${i}`,
            `${listFirstName[Math.floor(Math.random() * listFirstName.length)]} ${listMiddleName[Math.floor(Math.random() * listMiddleName.length)]} ${listLastName[Math.floor(Math.random() * listLastName.length)]}`,
            listDepartment[Math.floor(Math.random() * listDepartment.length)],
            randomPhoneNumber(),
            'Hà Nội'
        )
    )
}

export default function StickyHeadTable() {
    const [page, setPage] = React.useState(0);
    const [rowsPerPage, setRowsPerPage] = React.useState(5);

    const [openForm, setOpenForm] = React.useState(false);

    const handleOpenForm = () => {
        setOpenForm(true);
    };

    const handleCloseForm = () => {
        setOpenForm(false);
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
            <EmployeeForm open={openForm} handleClose={handleCloseForm} />
            <Stack direction="row" alignItems="center" justifyContent="space-between" mb={5}>
                <Typography variant="h4">Danh sách đơn vị/phòng ban</Typography>

                <Button onClick={handleOpenForm} variant="contained" color="inherit" startIcon={<Iconify icon="eva:plus-fill" />}>
                    Tạo mới
                </Button>
            </Stack>
            <TableContainer sx={{ overflow: 'auto', height: '450px' }} >
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
                            <TableCell align="right">Thao tác</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {rows
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
                                        <TableCell align="right">
                                            <Button sx={{ marginRight: 2 }} variant="contained" color="inherit" startIcon={<Iconify icon="eva:edit-2-fill" />}>
                                                Sửa
                                            </Button>
                                            <Button variant="contained" color="error" startIcon={<Iconify icon="eva:trash-fill" />}>
                                                Xóa
                                            </Button>
                                        </TableCell>
                                    </TableRow>
                                );
                            })}
                    </TableBody>
                </Table>
            </TableContainer>
            <TablePagination
                rowsPerPageOptions={[5, 20, 100]}
                component="div"
                count={rows.length}
                rowsPerPage={rowsPerPage}
                page={page}
                onPageChange={handleChangePage}
                onRowsPerPageChange={handleChangeRowsPerPage}
            />
        </Paper>
    );
}
