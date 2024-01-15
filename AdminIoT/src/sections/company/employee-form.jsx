/* eslint-disable  */

import { useState } from 'react';
import PropsType from 'prop-types';

// import Paper from '@mui/material/Paper';
import {
    Paper,
    Grid,
    Stack,
    Button,
    Backdrop,
    TextField,
    IconButton,
    Typography,
}
    from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';

import SelectVariants from 'src/components/select/select-varient';

export default function Form({ open, handleClose }) {
    return (
        <Backdrop
            sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }}
            open={open}
        >
            <Paper sx={{ width: '50%', overflow: 'auto', padding: 3 }}>
                <Stack direction="row" alignItems="center" justifyContent="space-between" mb={1}>
                    <Typography variant="h4" gutterBottom>
                        Thêm mới nhân viên
                    </Typography>
                    <IconButton onClick={handleClose} >
                        <CloseIcon />
                    </IconButton>
                </Stack>
                <Grid container spacing={2}>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            required
                            id="employeeCode"
                            name="employeeCode"
                            label="Mã nhân viên"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            required
                            id="fullName"
                            name="fullName"
                            label="Tên nhân viên"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            required
                            id="identityCard"
                            name="identityCard"
                            label="CCCD/CMND"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            required
                            id="phone"
                            name="phone"
                            label="Số điện thoại"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            id="address"
                            name="address"
                            label="Địa chỉ"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            id="email"
                            name="email"
                            label="Email"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <SelectVariants
                            options={[
                                { id: 1, value: 1, name: 'Nam' },
                                { id: 2, value: 2, name: 'Nữ' }
                            ]}
                            label="Giới tính"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <SelectVariants
                            options={[
                                { id: 1, value: 1, name: 'Phòng nhân sự' },
                                { id: 2, value: 2, name: 'Phòng kế toán' },
                                { id: 3, value: 3, name: 'Phòng phát triển' },
                            ]}
                            label="Đơn vị/Phòng ban"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            required
                            id="username"
                            name="username"
                            label="Tên đăng nhập"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField
                            required
                            id="password"
                            name="password"
                            label="Mật khẩu"
                            fullWidth
                            variant="standard"
                        />
                    </Grid>
                    <Grid item xs={12}>
                        <Button variant='contained' fullWidth sx={{ fontSize: 20, margin: '10px auto', display: 'block' }}>Thêm</Button>
                    </Grid>
                </Grid>
            </Paper>
        </Backdrop>
    );
}

Form.propTypes = {
    open: PropsType.bool,
    handleClose: PropsType.func,
};